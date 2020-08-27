require 'line/bot' 

class WebhooksController < ApplicationController
  def receive
    p "start3", params["events"][0]

    event = params["events"][0]

    message = {
      type: 'template',
      altText: 'altTextです',
      template: {
        type: 'buttons',
        title: 'titleですね',
        text: '日にちを選択してください',
        actions: [
          {
            type: 'datetimepicker',
            label:"Select date",
            data:"storeId=12345",
            mode:"datetime",
            initial:"2017-12-25t00:00",
            max:"2018-01-24t23:59",
            min:"2017-12-25t00:00"
          }
          
        ]
      }
    }
    client = Line::Bot::Client.new { |config|
        config.channel_secret = "xxxx"
        config.channel_token = "xxxx"
    }
    response = client.reply_message(event["replyToken"], message)
    p response.body
  end

  def test
    p "test start"
  end
end
