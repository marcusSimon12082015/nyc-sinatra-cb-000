class CreateFigureTitles < ActiveRecord::Migration[5.1]
  def change
    create_table :figure_titles do |t|
      t.belongs_to :figure
      t.belongs_to :title
    end
  end
end
