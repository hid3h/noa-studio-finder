class Api::V1::StudiosController < ApplicationController
  def index
    p "start3", params

    StudioBooking.search

    render :json => "test start"
  end
end
