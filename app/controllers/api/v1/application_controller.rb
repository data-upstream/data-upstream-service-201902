#module Api::V1
  # fixme https://stackoverflow.com/questions/42795288/rails-5-api-protect-from-forgery
  class ApplicationController < ActionController::API
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    #protect_from_forgery with: :null_session

    #FIXME
    include Sessions
  end
#end
