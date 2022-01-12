class V1::ChatsController < ApplicationController
  before_action :set_chat, only: [:show, :update, :destroy]

  # GET /chats
  def index
    @chats = Chat.all

    render json: @chats
  end

  # GET /chats/1
  def show
    render json: @chat
  end

  # POST /chats
  def create
    
    number = Redis.current.incr(params[:application_id])
    
    application_id = Application.where(token: params[:application_id]).first.id


    # @chat = Chat.new({number: number,application_id: application_id})
    render json: {number: number }, status: :created
    # if @chat.save
    #   render json: {number: number }, status: :created
    # else
    #   render json: @chat.errors, status: :unprocessable_entity
    # end
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
    @chat.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chat
      @chat = Chat.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def chat_params
      params.require(:chat).permit(:number, :messages_count)
    end
end
