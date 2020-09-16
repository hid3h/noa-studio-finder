class Message
  include ActiveModel::Serialization

  attr_accessor :quickReply, :type, :altText, :template

  def initialize(quickReply: nil, type:, altText: "altText", template:)
    @quickReply = quickReply
    @type = type
    @altText = altText
    @template = template
  end

  def attributes
    @template = @template.serializable_hash
    {
      'quickReply' => nil,
      'type' => nil,
      'altText' => nil,
      'template' => nil,
    }
  end
end
