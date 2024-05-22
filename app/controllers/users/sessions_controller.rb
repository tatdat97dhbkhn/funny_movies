# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    layout 'application'
  end
end
