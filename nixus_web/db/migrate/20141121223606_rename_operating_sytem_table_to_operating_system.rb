class RenameOperatingSytemTableToOperatingSystem < ActiveRecord::Migration
  def change
	rename_table :operating_sytems, :operating_systems
  end
end
