class WelcomeController < ApplicationController

  skip_before_action :validate_user

  def index

  end
end
