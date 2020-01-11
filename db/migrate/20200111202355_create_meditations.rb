class CreateMeditations < ActiveRecord::Migration[6.0]
  def change
    create_table :meditations do |t|
      t.string :user
      t.string :datetime
      t.integer :stresslevelbefore
      t.integer :stresslevelafter
      t.string :emotions
      t.string :meditation

      t.timestamps
    end
  end
end
