# frozen_string_literal: true

module ModelHelpers
  def reload_models(*models)
    models.each(&:reload)
  end
end
