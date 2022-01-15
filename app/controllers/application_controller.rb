class ApplicationController < ActionController::API
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    rescue_from ActionController::RoutingError, with: :not_found

    def route_not_found
        render json: {Error: 404, Message: "route not found."}, status: :not_found
    end

    def not_found(e)
        render json: {  title: "Record not Found",
            status: 404,
            detail: "We could not find the object you were looking for.",}, status: :not_found
    end
end
