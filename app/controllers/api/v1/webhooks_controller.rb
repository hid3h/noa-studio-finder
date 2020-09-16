require 'line/bot' 

class Api::V1::WebhooksController < ApplicationController
  def receive
    p "start3", params["events"][0]

    event = params["events"][0]

    # message = {
    #   type: 'template',
    #   altText: 'altTextです',
    #   template: {
    #     type: 'buttons',
    #     title: 'titleですね',
    #     text: '日にちを選択してください',
    #     actions: [
    #       {
    #         type: 'datetimepicker',
    #         label:"Select date",
    #         data:"storeId=12345",
    #         mode:"datetime",
    #         initial:"2017-12-25t00:00",
    #         max:"2018-01-24t23:59",
    #         min:"2017-12-25t00:00"
    #       }
          
    #     ]
    #   }
    # }

    message = {
      type: "carousel",
    "text": "Hello, world",
      quickReply: {
        items: [
          {
            type: "action",
            action: {
              type: "cameraRoll",
              label: "Send photo"
            }
          },
          {
            type: "action",
            action: {
              type: "camera",
              label: "Open camera"
            }
          }
        ]
      }
    }
    client = Line::Bot::Client.new { |config|
        config.channel_secret = Rails.application.credentials.line[:channel_secret]
        config.channel_token  = Rails.application.credentials.line[:channel_access_token]
    }
    
    response = client.reply_message(event["replyToken"], create_carousel_template)
    p response.body
  end

  def test
    p "test start"
    p create_carousel_template
    render :json => "test start"
  end

  def create_carousel_template
    columns = [{
      text: "学芸大",
      actions: [
        PostbackAction.new(
          label: "空室検索",
          data: "action=buy&itemid=111"
        ).serializable_hash
      ]
    }]

    template_obj = CarouselTemplate.new(columns: columns)

    message = Message.new(
      type: "template",
      template: template_obj
    ).serializable_hash

    message
  end
end
