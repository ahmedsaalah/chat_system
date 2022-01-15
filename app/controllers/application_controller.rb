class ApplicationController < ActionController::API
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    rescue_from ActionController::RoutingError, with: :not_found
    rescue_from ActionController::ParameterMissing , with: :unprocessable_entity


    def route_not_found
        render json: {Error: 404, detail: "route not found."}, status: :not_found
    end

    def not_found(e)
        render json: {  title: "Record not Found",
            status: 404,
            detail: "We could not find the object you were looking for.",}, status: :not_found
    end
    def unprocessable_entity(e)
        render json: {  title: "Validation Error" , status: 422 , detail: e }, status: :unprocessable_entity
    end
end
