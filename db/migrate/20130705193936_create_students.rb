class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :name
      t.string :email
      t.string :pic_file_name
      t.string :avatar_file_name
      t.string :tag_line
      t.text :bio
      t.string :blog
      t.string :treehouse
      t.string :codeschool
      t.string :coderwall
      t.string :linkedin
      t.string :website
      t.string :twitter

      t.timestamps
    end
  end
end
