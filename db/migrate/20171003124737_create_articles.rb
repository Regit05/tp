class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :text
      t.string :image_url, :default => "http://st.gde-fon.com/wallpapers_original/572296_abstraktsiya_tigr_3d_art_2560x1600_www.Gde-Fon.com.jpg"

      t.timestamps
    end
  end
end
