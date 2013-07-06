class Student < ActiveRecord::Base
  attr_accessible :avatar_file_name, :bio, :blog, :coderwall, :codeschool, :email, :linkedin, :name, :pic_file_name, :tag_line, :treehouse, :twitter, :website

  # the name is mandatory
  validates_presence_of :name, :message => "must not be blank."

  # email is properly formatted
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :message => "doesn't look like a proper email address."

  validates_uniqueness_of :email, :case_sensitive => false, :message =>"has already been entered, you can only have a single profile."



end
