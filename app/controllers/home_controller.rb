class HomeController < ApplicationController

  def index
  end # End of Index

  def yo
    logger.info "############## Yo received from : #{params[:username]}"
    respond_to do |format|
      format.all { render :nothing => true, :status => 200 }
    end
  end
end