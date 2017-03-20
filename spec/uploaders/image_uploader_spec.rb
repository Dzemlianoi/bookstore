describe AttachmentsUploader do
  let(:file) { fixture_file_upload("#{fixture_path}/books/test_book.jpg") }
  let(:picture) { create :image }
  let(:uploader) { AttachmentsUploader.new(picture, :book) }

  before do
    AttachmentsUploader.enable_processing = true
    File.open(file) { |f| uploader.store!(f) }
  end

  after do
    AttachmentsUploader.enable_processing = false
  end

  context 'the thumb version' do
    it '400 x 400' do
      expect(uploader.large).to have_dimensions(400, 400)
    end
  end

  context 'the small version' do
    it '50 x 50' do
      expect(uploader.thumb).to be_no_larger_than(50, 50)
    end
  end
end