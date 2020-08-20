class CreateBrands < ActiveRecord::Migration[5.2]
  def change
    create_table :brands do |t|
      t.string     :name, 	 null: false, index: true, length: { maximum: 40 }
      t.string     :origin,  null: false
      t.text       :explain, null: false, length: { maximum: 1_000 }
      t.string     :year
      t.string     :value
      t.integer    :scene
      t.integer    :taste
      t.integer    :likes_count
      t.references :user,    null: false
      t.references :type
      t.references :variety
      t.timestamps
    end
  end
end
