class AttachmentsUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    'book_default.jpg'
  end

  version :thumb do
    process resize_to_fit: [50, 50]
  end

  version :large do
    process resize_to_fit: [400, 400]
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end
