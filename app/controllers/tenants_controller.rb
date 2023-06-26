class TenantsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_record_response
    rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found_response

    def index
        tenants = Tenant.all
        render json: tenants
    end

    def show
        tenant = Tenant.find(params[:id])
        render json: tenant, status: :ok
    end

    def create
        tenant = Tenant.create!(tenant_params)
        render json: tenant, status: :created
    end

    def update
        tenant = Tenant.find(params[:id])
        tenant.update!(tenant_params)
        render json: tenant, status: :ok
    end
    
    def destroy
        tenant = Tenant.find(params[:id])
        tenant.destroy
        head :no_content
    end

    private

    def tenant_params
        params.permit(:name, :age)
    end

    def render_record_not_found_response
        render json: { errors: "Record Not Found"}, status: :not_found
    end

    def render_invalid_record_response(exception)
        render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
    end

end
