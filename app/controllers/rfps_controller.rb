class RfpsController < ApplicationController
before_action :set_rfp, only: [:show, :update, :destroy]

  # GET /rfp
  def index
    # get current user todos
	
	selectcolumn = "rfps.*,appr_user.name as approver_name, req_user.name requested_by_name, req_user.img_url requested_by_img_path, projects.name project_name"
	@rfp = Rfp.joins("INNER JOIN projects as projects ON projects.id = rfps.project_id")
			  .joins("INNER JOIN users as req_user ON req_user.id = rfps.requested_by_id")
			  .joins("INNER JOIN users as appr_user ON appr_user.id = rfps.approver_id")
			.where("rfps.is_active = ?", params[:is_active] ||= 1 )
	
	if params[:id] != nil 
		@rfp = @rfp.where("rfps.id = ?", params[:id])
	end
	if params[:approver_id] != nil 
		@rfp = @rfp.where("rfps.approver_id = ?", params[:approver_id])
	end
	if params[:requested_by_id] != nil 
		@rfp = @rfp.where("rfps.requested_by_id = ?", params[:requested_by_id])
	end
	@rfp = @rfp.order("rfps.id DESC")
	 
	@count  = @rfp.count
	@rfp  =  @rfp.select(selectcolumn)
	@rfp  =  @rfp.offset(params[:start] ||= 0).limit(params[:limit] ||= 50)
	success = true

    json_response(success: success, count: @count , list: @rfp )
	
  end

  # GET /rfps_list
  def list
    # get current user todos
	
	@rfp = Rfp.select('*').where("created_by = ? and is_active = ?  ", current_user.id, params[:is_active] ||= 1 )
	@rfp = @rfp.order("id DESC")
	
	@count  = @rfp.count
	@rfp  =  @rfp.offset(params[:start] ||= 0).limit(params[:limit] ||= 50)

	success = true;

    json_response(success: success, count: @count , list: @rfp )
	
  end

   # GET /rfps_pendinglist
  def pendinglist
    # get current user todos
	
	@rfp = Rfp.select('*').where("approver_id = ? and is_active = ?  ", current_user.id, params[:is_active] ||= 1 )
	@rfp = @rfp.order("id DESC")
	
	@count  = @rfp.count
	@rfp  =  @rfp.offset(params[:start] ||= 0).limit(params[:limit] ||= 50)

	success = true;

    json_response(success: success, count: @count , list: @rfp )
	
  end

  # GET /rfp/:id
  def show
    json_response(@rfp)
  end

  # POST /rfp
  def create
   rfp_params = JSON.parse(request.body.read).symbolize_keys
  
   @rfp = Rfp.create!(rfp_params)
   @rfp.created_by = current_user.id 
   @rfp.updated_by = current_user.id
   @rfp.save
   json_response(success: true, info: @rfp, message: "RFP Created Successfully")
  end

  # PUT /rfp/:id
  def update
    @rfp.update(rfp_params)
    @rfp.updated_by = current_user.id
    @rfp.save

    json_response(success: true, message: "RFP Modified Successfully")
  end

  # DELETE /rfp/:id
  def destroy
    @rfp.destroy
    json_response(success: true, message: "RFP Deleted Successfully")
  end

  private

  # remove `created_by` from list of permitted parameters
  def rfp_params
    params.permit(:no,:bid_number,:project_id,:format,:title,:description,:rfptype,:permits,:requested_by_id,:requested_by_name,:plan_start_date,:approver_id,:approver_name)
  end

  def set_rfp
    @rfp = Rfp.find(params[:id])
  end
end
