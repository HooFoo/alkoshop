class DefaultAdmin < ActiveRecord::Migration[5.0]
  def change
    AdminUser.create! email: 'admin@admin.com',
                      password: 'administrator',
                      password_confirmation: 'administrator'
  end
end
