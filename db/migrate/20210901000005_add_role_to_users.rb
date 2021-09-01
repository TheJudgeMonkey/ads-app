# frozen_string_literal: true

class AddRoleToUsers < ActiveRecord::Migration[6.1]
  def up
    add_column :users, :role, :string

    User.find_each do |user|
      user.update!(role: :user)
    end

    change_column_null :users, :role, false
  end

  def down
    remove_column :users, :role
  end
end
