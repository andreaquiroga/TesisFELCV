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
  validates :ci,
    :presence  => { :message => " es requerido " },
    :length => {:minimum => 5, :maximum => 10, :message => "tiene como longitud minina 5 y como maxima 10"},
    :uniqueness  => { :message => " existente, elija otro " },
    :numericality => {:only_integer => true, :message => " debe ser un numero"}
  # :cert
  # :private_key

  validates :name, :paternal_last_name, :grade, :address, :last_work,
    :presence  => { :message => " es requerido " },
    :length => {:minimum => 1, :message => " tiene como longitud minina: 1 "}
  
  :maternal_last_name

  validates :phone,
    :presence  => { :message => " es requerido " },
    :length => {:minimum => 6, :message => " tiene como longitud minina: 6 "},
    :numericality => {:only_integer => true, :message => " debe ser un numero"} 
    
  validates :mobile,
    :presence  => { :message => " es requerido " },
    :length => {:minimum => 8,  :message => " tiene como longitud minina: 8 "},
    :numericality => {:only_integer => true, :message => " debe ser un numero"}

  validates :admission_date,
    :presence  => { :message => " es requerido " }

  validates :birthdate,
    :presence => { :message => " es requerido " }
  validates :status,
    :presence => { :message => " es requerido"}
  :remember_me
  :turn
  
  has_attached_file :upload_cert,
    :storage => :dropbox,
    :dropbox_credentials => Rails.root.join("config/dropbox.yml"),
    :dropbox_options => {:path => proc{|style| "certs/#{id}/#{upload_cert.original_filename}"}}
  validates_attachment_content_type :upload_cert, :content_type => ["file/cer"]

  belongs_to :station

  def role?(r)
    role.include? r.to_s
  end

  def signed_first?
    if sign_in_count==1
      true
    else
      false
    end
  end

  def status?(st)
    if status==st
      true
    else
      false
    end
  end
end
