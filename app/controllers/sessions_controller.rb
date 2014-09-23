class SessionController < Devise::SessionController
def index
  end

  def new
    #this function will go to sign in page
    @user = User.new #you can ignore this code, I create this in purpose for my sign in form
  end

  def create
    super
  end

  def destroy
    super
  end
end