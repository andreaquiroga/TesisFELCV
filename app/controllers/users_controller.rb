class UsersController < ApplicationController


def new
	@user=User.new
	@user.status="Inactivo"
	pass="12345678"
	@user.password=pass
	@user.password_confirmation=pass
end

def create
	@user = User.new(user_params)
	if @user.role?("investigador")
		@max=User.maximum("turn")
		@user.turn=(@max.to_i+1).to_s
	end
	@user.valid?
	if @user.errors.blank?
		if @user.save(:validate=>false)
			flash[:notice] = "Usuario registrado."
			redirect_to user_path(@user.id)
		end
	else
		render :action => "new"
	end
end

def index
	@station=Station.find(params[:id])
	@users=User.where(:station_id=>@station.id)
end

def show
	@user=User.find(params[:id])
end

def upload_cert
	@user = User.find(params[:id])
end

def save_cert
	@user = User.find(params[:user][:id])
	@user.upload_cert = params[:user][:upload_cert]
	respond_to do |format|
	    if @user.save(:validate=>false)   
	      format.html { redirect_to user_path(@user.id), notice: 'Certificado guardado' }
        	format.json { render action: 'show', status: :created, location: @user }
	    else                              
	      format.html { render action: 'upload_cert' }
          format.json { render json: @user.errors, status: :unprocessable_entity }
	    end
		end
end

def edit_status
	@user = User.find(params[:user][:id])
	@user.status = params[:user][:status]
	@user.save(:validate=>false)
	redirect_to user_path(@user.id)
end

def edit
	@user =  User.find(current_user.id)
end

def update
	@user.attributes = params[:user]  
    # required for settings form to submit when password is left blank
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
        params[:user].delete(:password)
        params[:user].delete(:password_confirmation)
    end

    @user = User.find(current_user.id)
    if @user.update_attributes(params[:user])
      set_flash_message :notice, :updated
      # Sign in the user bypassing validation in case his password changed
      sign_in @user, :bypass => true
      redirect_to after_update_path_for(@user)
    else
      render "edit"
    end
end

def edit_password
    @user = current_user
end

def update_password
	@user = User.find(current_user.id)
	if @user.valid_password?(params[:actual_password])
		respond_to do |format|
	    if @user.update(user_params_password)
	      # Sign in the user by passing validation in case his password changed
	      @user.status="Activo"
	      @user.save(:validate => false)
	      sign_in @user, :bypass => true

	      
	      format.html { redirect_to root_path, notice: 'Contrasenia modificada.' }
        	format.json { render action: 'root', status: :created, location: @user }
	    else                              
	      format.html { render action: '_change_password' }
          format.json { render json: @user.errors, status: :unprocessable_entity }
	    end
		end
	else
		flash[:error]="Contrasenia actual incorrecta"
		redirect_to root_path
	end

  end

def user_params_password
	params.require(:user).permit(:password, :password_confirmation)
end

def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role, :ci, :name, :paternal_last_name, :maternal_last_name, :grade, :address, :phone, :mobile, :birthdate, :admission_date, :last_work, :status, :station_id, :turn)
end

end
