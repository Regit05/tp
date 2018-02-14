class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception


  def index
  end

  def changelanguage
      cookies[:language] = {
          value: params[:langue],
          expires: 1.month.from_now
      }
      redirect_to admins_path
  end


end
