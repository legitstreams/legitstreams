# encoding: utf-8

class PosterUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  # include Sprockets::Helpers::RailsHelper
  # include Sprockets::Helpers::IsolatedHelper

  # Choose what kind of storage to use for this uploader:
  #  storage :file
    storage :fog

  # Override the directory where uploaded files will be stored.
  ## This is a sensible default for uploaders that are meant to be mounted:

  def store_dir

    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/" + model.title.gsub(CarrierWave::SanitizedFile.sanitize_regexp,"_").downcase
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
   version :thumb do
    process :resize_and_pad => [50, 50]
    process :convert => 'jpeg'

   end

  version :movie_poster do
    process :resize_and_pad => [220, 325]
    process :convert => 'jpeg'
  end

  version :movie_small_poster do
      process :resize_and_pad => [130, 185]
      process :convert => 'jpeg'
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  #def extension_white_list
  #   %w(jpg jpeg gif png)
  #end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
   def filename
      ("#{model.title}_#{model.year}.#{file.extension}").gsub(CarrierWave::SanitizedFile.sanitize_regexp,"_").downcase! if original_filename
   end

end
