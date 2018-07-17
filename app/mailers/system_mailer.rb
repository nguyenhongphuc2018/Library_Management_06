class MonthMailer < ApplicationMailer
  def moth user
    @user = user
    mail to: @user.email, subject: t(".rejected_subject")
  end
  def every_day user
    @user = user
    mail to: @user.email, subject: t(".rejected_subject")
  end
end
