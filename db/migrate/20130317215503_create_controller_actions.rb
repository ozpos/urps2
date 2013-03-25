class CreateControllerActions < ActiveRecord::Migration
  def change
    create_table :controller_actions do |t|
      t.string :name
      t.references :action_name, index: true
      t.references :controller_name, index: true

      t.timestamps
    end
  end
end
