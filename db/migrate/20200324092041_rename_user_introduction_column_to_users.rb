class RenameUserIntroductionColumnToUsers < ActiveRecord::Migration[5.2]
  def change
  	rename_column :users, :user_introduction, :introduction
  end
end
