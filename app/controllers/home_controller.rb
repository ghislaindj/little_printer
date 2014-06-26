class HomeController < ApplicationController

  def index
  end # End of Index

  def yo
    @username = params[:username].to_s

    yo = Yo.create(username: @username)
    yo.print

    respond_to do |format|
      format.all { render :nothing => true, :status => 200 }
    end
  end
end