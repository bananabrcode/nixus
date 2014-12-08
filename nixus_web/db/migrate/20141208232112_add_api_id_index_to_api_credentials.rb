class AddApiIdIndexToApiCredentials < ActiveRecord::Migration
  def change
    remove_index :api_credentials, :api_id
    add_index :api_credentials, :api_id, :unique => true
  end
end
