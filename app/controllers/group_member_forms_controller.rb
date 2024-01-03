class GroupMemberFormsController < ApplicationController
  def create
    @group = Group.find_or_initialize_by(id: params[:id])
    authorize @group
  end
end
