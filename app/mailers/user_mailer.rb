class UserMailer < ActionMailer::Base
  default from: "andy.afqy@gmail.com"
  def new_case_mailer(case_num, user)
  	@case = case_num
  	@user = user
  	mail(to: "andy.afqy@gmail.com", subject: 'Fuerza de Lucha Contr el crimen - Asignacion')

  end
end
