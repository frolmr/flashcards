class AddFieldToActivities < ActiveRecord::Migration[5.0]
  def change
    change_table :activities do |t|
      t.string :activity_type
    end
  end
end
