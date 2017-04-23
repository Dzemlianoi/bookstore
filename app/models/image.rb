# frozen_string_literal: true

class Image < ApplicationRecord
  belongs_to :imageable, polymorphic: true
  mount_uploader :attachment, AttachmentsUploader

  scope :newest, ->(num) { order('created_at ASC').limit(num) }
end
