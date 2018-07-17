class RequirementMailer < ApplicationMailer
  def approved user
    @user = user
    mail to: @user.email, subject: t(".approved_subject")
  end
  def rejected user
    @user = user
    mail to: @user.email, subject: t(".rejected_subject")
  end
end
