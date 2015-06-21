class UserMailer < ApplicationMailer

  default from: 'amarbir.s.gill@gmail.com'
  
  def goodbye_email(user)
    @user = user
    mail(to: @user.email, subject: 'Goodbye from Rotten Mangoes')
  end
end
