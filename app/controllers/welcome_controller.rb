class WelcomeController < ApplicationController
  def index
  	@user=current_user
  	@cases=Case.all
  end
end
