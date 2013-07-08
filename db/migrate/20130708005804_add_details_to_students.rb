class AddDetailsToStudents < ActiveRecord::Migration
  def change
    add_column :students, :github, :string
    add_column :students, :education, :string
    add_column :students, :work_experience, :string
  end
end
