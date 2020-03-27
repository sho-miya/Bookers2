class RenameBookNameColumnToBooks < ActiveRecord::Migration[5.2]
  def change
  	rename_column :books, :book_name, :title
  end
end
