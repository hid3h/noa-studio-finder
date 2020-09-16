class PostbackAction
  include ActiveModel::Serialization

  attr_accessor :type, :label, :data, :displayText

  def initialize(label: nil, data:, displayText: nil)
    @type = "postback"
    @label = label
    @data = data
    @displayText = displayText
  end

  def attributes
    {
      'type' => nil,
      'label' => nil,
      'data' => nil,
      'displayText' => nil
    }
  end
end
