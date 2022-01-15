class V1::ApplicationsController < ApplicationController
  before_action :set_application, only: [:show, :update, :destroy]

  # GET /applications
  def index
    @applications = Application.page(params[:page]||1).per(params[:per_page]||10)

    if @applications.out_of_range?
      render json: {status: 404 , message: "page out of range"},status: :not_found
    else
      render json: {applications: @applications , current_page: @applications.current_page, total_pages: @applications.total_pages}
    end
  end

  # GET /applications/1
  def show
    render json: @application

  end

  # POST /applications
  def create
    @application = Application.new(application_params)
    if @application.save
      render json:{ application: @application }, status: :created
    else
      render json: @application.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /applications/1
  def update
    if @application.update(application_params)
      render json: @application
    else
      render json: @application.errors, status: :unprocessable_entity
    end
  end

  # DELETE /applications/1
  def destroy
    if @application.destroy
      render json: @application
    else
      render json: @application.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_application
      @application = Application.where(token: params[:id]).first
      raise ActiveRecord::RecordNotFound unless @application.present?
    end

    # Only allow a trusted parameter "white list" through.
    def application_params
      params.require(:application).permit(:name)
    end
end
