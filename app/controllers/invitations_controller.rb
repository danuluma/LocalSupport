class InvitationsController < ApplicationController
  before_filter :authorize

  # Uses email to create invite, uses id to respond with msg
  def create
    res = params[:values].each_with_object({}) do |value, response|
      response[value[:id]] = invite_user(value[:email], params[:resend_invitation])
    end
    respond_to do |format|
      format.json { render :json => res.to_json }
    end
    debugger
    puts 'hi'
  end

  private
  def invite_user(email, resend_invitation)
    UserInviter.new(self, User, current_user, Devise).invite(
        email, resend_invitation)
  end
end