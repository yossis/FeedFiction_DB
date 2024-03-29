class RelationshipsController < ApplicationController
  before_filter :set_common_vars

  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js { render template: 'users/show_header' }
    end
    
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js { render template: 'users/show_header' }
    end
  end

  def set_common_vars
     @in_header = true if params[:is_header]=='true'
  end
end