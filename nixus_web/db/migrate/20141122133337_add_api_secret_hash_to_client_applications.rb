class AddApiSecretHashToClientApplications < ActiveRecord::Migration
  def change
    add_column :client_applications, :api_secret_hash, :string, :limit => 32
  end
end
