class Student < ActiveRecord::Base
  attr_accessible :avatar_file_name, :bio, :blog, :coderwall, :codeschool, :email, :linkedin, :name, :pic_file_name, :tag_line, :treehouse, :twitter, :website, :extension, :photo, :background

  # the name is mandatory
  validates_presence_of :name, :message => "must not be blank."

  # email is properly formatted
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :message => "doesn't look like a proper email address."

  validates_uniqueness_of :email, :case_sensitive => false, :message =>"has already been entered, you can only have a single profile."

  # after the person has been written to the database, deal with 
  # writing any image data to the filesystem   
  def store_photo
    if @file_data
      # make the photo_store directory if it doesn't exist already
      FileUtils.mkdir_p PHOTO_STORE
      # write out the image data to the file
      File.open(photo_filename, 'wb') do |f|
        f.write(@file_data.read)
      end
      # ensure file saved only when it newly arrives at model being saved
      @file_data = nil
    end
  end

  # after the background has been written to the database, deal with 
  # writing any image data to the filesystem   
  def store_background
    if @background_data
      # make the photo_store directory if it doesn't exist already
      FileUtils.mkdir_p PHOTO_STORE
      # write out the image data to the file
      File.open(background_filename, 'wb') do |f|
        f.write(@background_data.read)
      end
      # ensure file saved only when it newly arrives at model being saved
      @file_data = nil
    end
  end

  # when photo data is assigned via the upload, store the file data
  # for later and assign the file extension, e.g., ".jpg"
  def photo=(file_data) 
    unless file_data.blank?
      # store the uploaded data into a private instance variable
      @file_data = file_data
      # figure out the last part of the filename and use this as
      # the file extension. e.g., from "me.jpg" will return "jpg"
      self.extension = file_data.original_filename.split('.').last.downcase
    end
  end

  # when background data is assigned via the upload, store the file data
  # for later and assign the file extension, e.g., ".jpg"
  def background=(background_data) 
    unless background_data.blank?
      # store the uploaded data into a private instance variable
      @background_data = background_data
      # figure out the last part of the filename and use this as
      # the file extension. e.g., from "me.jpg" will return "jpg"
      self.background_extension = background_data.original_filename.split('.').last.downcase
    end
  end
  
  # File.join is a cross-platform way of joining directories;
  # we could have written "#{Rails.root}/public/photo_store"
  PHOTO_STORE = File.join Rails.root, 'public', 'photo_store'
  # where to write the image file to
  def photo_filename
    File.join PHOTO_STORE, "#{id}.#{extension}"
  end 

  # where to write the background image file to
  def background_filename
    File.join PHOTO_STORE, "background_#{id}.#{extension}"
  end 

  # return a path we can use in HTML for the image
  def photo_path
    "/photo_store/#{id}.#{extension}"
  end

  # return a path we can use in HTML for the background
  def background_path
    "/photo_store/background_#{id}.#{extension}"
  end

# if a photo file exists, then we have a photo
  def has_photo?
    File.exists? photo_filename
  end

# if a photo file exists, then we have a photo
  def has_background?
    File.exists? background_filename
  end

  after_save :store_photo
  after_save :store_background

end
