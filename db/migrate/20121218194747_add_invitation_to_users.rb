class AddInvitationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :invitation_id, :integer
    add_column :users, :invitation_limit, :integer ,default: 10
  end

  
end
