module BookDimensionsHelper
  def total_dimensions(dimensions)
    "H: #{dimensions.height}\" x W: #{dimensions.width}\" x D: #{dimensions.depth}\""
  end
end