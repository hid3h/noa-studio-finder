class Api::V1::StudiosController < ApplicationController
  def index
    result = StudioBooking.search

    render :json => result
  end
end
