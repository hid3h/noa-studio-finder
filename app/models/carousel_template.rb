class CarouselTemplate
  include ActiveModel::Serialization

  attr_accessor :type, :columns

  def initialize(columns: [])
    @type = "carousel"
    @columns = columns
  end

  def attributes
    {
      'type' => nil,
      'columns' => nil
    }
  end
end
