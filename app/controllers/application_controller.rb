class ApplicationController < ActionController::Base
  def current_user
    Struct.new(:id)
  end
end
