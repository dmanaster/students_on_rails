class AddBackgroundExtensionToStudents < ActiveRecord::Migration
  def change
    add_column :students, :background_extension, :string
  end
end
