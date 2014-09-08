class RegistrationController < Devise::RegistrationsController


def new
	@user=User.new
	@user.status="inactivo"
	pass="12345678"
	@user.password=pass
	@user.password_confirmation=pass
end

def create
	@user = User.new(user_params)
	@user.valid?
	if @user.errors.blank?
		if @user.save
			redirect_to root_path
		end
	else
		render :action => "new"
	end
end
def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :role, :ci, :name, :paternal_last_name, :maternal_last_name, :grade, :address, :phone, :mobile, :birthdate, :admission_date, :last_work, :status)
end

end
