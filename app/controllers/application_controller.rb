class ApplicationController < ActionController::API
  def health
    render :json => "noa"
  end
end
