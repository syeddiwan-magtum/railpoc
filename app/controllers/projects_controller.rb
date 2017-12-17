class ProjectsController < ApplicationController

  # GET /Project
  def index
    # get current user Project
    @project = Project.where("is_active = ?", params[:is_active] ||= 1 ).offset(params[:start] ||= 0).limit(params[:limit] ||= 50)
	@count  =  Project.where("is_active = ?", params[:is_active] ||= 1 ).count
	success = true;

    json_response(success: success, count: @count , list: @project )
	#json_response(@project )
  end

  def create
    # get current user Project
    @project = Project.create!(project_params)
	success = true;
    json_response(success: success, message: 'Project Created Successfully' , info: @project )
  end  	


  private

  # remove `created_by` from list of permitted parameters
  def project_params
	params.permit(:name, :is_active, :start, :limit )
  end


end
