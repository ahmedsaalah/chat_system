class V1::ChatsController < ApplicationController
  before_action :set_chat, only: [:show, :update, :destroy]

  # GET /chats
  def index
    @chats = Chat.page(params[:page]||1).per(params[:per_page]||10)

    if @chats.out_of_range?
      render json: {status: 404 , message: "page out of range"},status: :not_found
    else
      render json: {chats: @chats , current_page: @chats.current_page, total_pages: @chats.total_pages}
    end
  end

  # GET /chats/1
  def show
    render json: @chat
  end

  # POST /chats
  def create
  
    number = Redis.current.incr(params[:application_id])
    application_id = Application.where(token: params[:application_id]).first.id
    CreatorWorker.perform_async("chat",{number: number,application_id: application_id})
    render json: {number: number }, status: :created
  end

  # PATCH/PUT /chats/1
  def update
    if @chat.update(chat_params)
      render json: @chat
    else
      render json: @chat.errors, status: :unprocessable_entity
    end
  end

  # DELETE /chats/1
  def destroy
    if @chat.destroy
      render json: @chat
    else
      render json: @chat.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chat
      @chat = Application.where(token: params[:application_id]).first.chats.where(number: params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def chat_params
      params.require(:chat).permit()
    end
end
