class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :email,
  	:presence  =>  { :message => " es requerido" }
  validates :password,
  	:presence  =>  { :message => " es requerido" }
  validates :password_confirmation,
  	:presence  =>  { :message => " es requerido" }
  validates :role,
  	:presence  =>  { :message => " es requerido" }
  :remember_me
  has_one :official

  def role?(r)
    role.include? r.to_s
  end
end
