class CreateInteractions < ActiveRecord::Migration
  def change
    create_table :interactions do |t|
      t.references :controller_action, index: true
      t.references :role, index: true

      t.timestamps
    end
  end
end
