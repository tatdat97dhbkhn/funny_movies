# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend

  protected

  def devise_parameter_sanitizer
    if resource_class == User
      Users::ParameterSanitizer.new(User, :user, params)
    else
      super
    end
  end
end
