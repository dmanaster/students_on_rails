class AddPhotoExtensionToStudents < ActiveRecord::Migration
  def change
    add_column :students, :extension, :string
  end
end
