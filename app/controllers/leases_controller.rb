class LeasesController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid_response

    def index
        leases = Lease.all
        render json: leases, status: :ok
    end
    
    def create
        lease = Lease.create(lease_params)
        render json: lease, status: :created
    end

    def destroy
        lease = Lease.find(params[:id])
        lease.destroy
        head :no_content
    end

    private

    def lease_params
        params.permit(:rent, :apartment_id, :tenant_id)
    end

    def render_record_invalid_response
        render json: { errors: "not found"}, status: :not_found
    end

end
