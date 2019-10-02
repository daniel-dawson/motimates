class PreferencesController < ApplicationController
  load_and_authorize_resource through: :current_user, singleton: true
end
