class V1::MessagesController < ApplicationController
  before_action :set_message, only: [:show, :update, :destroy]

  # GET /messages
  def index
    @messages = Message.page(params[:page]||1).per(params[:per_page]||10)

    if @messages.out_of_range?
      render json: {status: 404 , message: "page out of range"},status: :not_found
    else
      render json: {applications: @messages , current_page: @messages.current_page, total_pages: @messages.total_pages}
    end

  end

  # GET /messages/1
  def show
    render json: @message
  end

  # POST /messages
  def create
    number = Redis.current.incr("#{params[:application_id]}-#{params[:chat_id]}")
    chat_id = Chat.where(number: params[:chat_id]).first.id
    CreatorWorker.perform_async("message",{text: message_params[:text], number: number, chat_id: chat_id})
    render json: {number: number }, status: :created
  end

  # PATCH/PUT /messages/1
  def update
    if @message.update(message_params)
      render json: @message
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  # DELETE /messages/1
  def destroy
    @message.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Application.where(token: params[:application_id]).first.chats.where(number: params[:chat_id]).first.messages.find_by(number: params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def message_params
      params.require(:message).permit(:text)
    end
end
