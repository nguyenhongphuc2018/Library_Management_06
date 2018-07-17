class RequirementMailer < ApplicationMailer
  def approved_mailer user
    @user = user
    mail to: @user.email, subject: t(".approved")
  end
  def rejected_mailer user
    @user = user
    mail to: @user.email, subject: t ".rejected"
  end
end
