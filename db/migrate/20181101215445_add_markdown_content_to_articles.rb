class AddMarkdownContentToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :markdown_content, :text
  end
end
