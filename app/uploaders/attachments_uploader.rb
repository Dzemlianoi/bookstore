# frozen_string_literal: true

class AttachmentsUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
  include CarrierWave::MiniMagick

  def default_url
    'book_default.jpg'
  end

  version :thumb do
    process resize_to_fit: [50, 50]
  end

  version :large do
    process resize_to_fit: [400, nil]
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end
