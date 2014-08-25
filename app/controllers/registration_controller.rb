class RegistrationController < Devise::RegistrationsController


def new
	@user=User.new
end

def create
	@user = User.new(user_params)
	@user.valid?
	if @user.errors.blank?
		if @user.save
			redirect_to new_official_path(@user.id.to_s)
		end
	else
		render :action => "new"
	end
end
def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :role)
end

end
