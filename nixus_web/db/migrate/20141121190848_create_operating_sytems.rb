class CreateOperatingSytems < ActiveRecord::Migration
  def change
    create_table :operating_sytems do |t|
      t.string :displayName
      t.string :cpeName
      t.string :cpuArchitecture

      t.timestamps
    end
  end
end
