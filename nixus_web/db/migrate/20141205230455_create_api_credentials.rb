class CreateApiCredentials < ActiveRecord::Migration
  def change
    create_table :api_credentials do |t|
      t.string :api_id
      t.string :api_secret_hash

      t.timestamps
    end
    add_index :api_credentials, :api_id
  end
end
