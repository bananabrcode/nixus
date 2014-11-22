class RenameOperatingSystemRefToClientApplications < ActiveRecord::Migration
  def change
    remove_reference :client_applications, :OperatingSystem, index: true
    add_reference :client_applications, :operating_system, index: true
  end
end
