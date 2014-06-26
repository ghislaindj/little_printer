class Backoffice::HomeController < Backoffice::BaseController
  def dashboard
    unless admin_signed_in?
      redirect_to new_backoffice_admin_session_path
    end
  end
end