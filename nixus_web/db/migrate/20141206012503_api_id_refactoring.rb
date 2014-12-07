class ApiIdRefactoring < ActiveRecord::Migration
  def change
	change_table :client_applications do |t|
		t.remove :api_id
		t.remove :api_secret_hash
	end

	add_column :api_credentials, :api_authenticable_id, :integer
	add_column :api_credentials, :api_authenticable_type, :string
	change_table :api_credentials do |t|
		t.string :apid_id, :limit => 32
		t.string :apid_secret_hash, :limit => 32
	end
  end
end
