class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def edit
    @group = Group.find(params[:id])
  end

  def create
    @group = Group.new(group_params)
    @group_form = GroupForm.new(group_params)
    if @group_form.save
      redirect_to groups_path
    else
      flash.now[:error] = @group_form.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @group = Group.find(params[:id])
    @group_form = GroupForm.new(group_params.merge(group: @group))
    if @group_form.update
      redirect_to groups_path
    else
      flash.now[:error] = @group_form.errors.full_messages
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :mattermost_channel_id).merge(group_member_ids: params[:group_member_ids])
  end
end
