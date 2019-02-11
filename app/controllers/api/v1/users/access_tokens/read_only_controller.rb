module Api::V1

  class Users::AccessTokens::ReadOnlyController < ApplicationController
    include Api::V1::Concerns::Sessions

    before_action :require_read_write_user_access_token

    def index
      @tokens = current_user.access_tokens.where(read_only: true)
      render json: @tokens
    end
  end

end