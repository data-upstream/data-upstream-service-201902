#  https://stackoverflow.com/questions/42795288/rails-5-api-protect-from-forgery
class ApplicationController < ActionController::API
  include Sessions
end
