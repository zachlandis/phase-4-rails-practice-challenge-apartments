class ApartmentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_record_response

    def index
        apartments = Apartment.all
        render json: apartments
    end

    def show
        apartment = Apartment.find(params[:id])
        render json: apartment, status: :found
    end

    def create
        apartment = Apartment.create(apartment_params)
        render json: apartment, status: :created
    end

    def update
        apartment = Apartment.find(params[:id])
        apartment.update(apartment_params)
        render json: apartment, status: :ok
    end
    
    def destroy
        apartment = Apartment.find(params[:id])
        apartment.destroy
        head :no_content
    end

    private 

    def apartment_params
        params.permit(:number)
    end

    def render_record_not_found_response
        render json: {errors: "Apartment not found"}, status: :not_found
    end

    def render_invalid_record_response(exception)
        render json: { errors: exception.record.errors.full_messages}, status: :unprocessable_entity
    end
end
