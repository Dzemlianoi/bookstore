module BookMaterialsHelper
  def all_materials(book)
    book.materials.map(&:name).join(', ')
  end
end