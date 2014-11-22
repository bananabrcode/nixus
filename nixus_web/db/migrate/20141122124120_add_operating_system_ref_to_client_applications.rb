class AddOperatingSystemRefToClientApplications < ActiveRecord::Migration
  def change
    add_reference :client_applications, :OperatingSystem, index: true
  end
end
