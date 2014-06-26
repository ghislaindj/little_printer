class HomeController < ApplicationController

  def index
  end # End of Index

  def yo
    @username = params[:username].to_s
    @yo = Yo.create(username: @username)

    html = render_to_string "home/yo_layout", :layout => false

    #unless Rails.env == "development"
      @yo.print html
    #end

    respond_to do |format|
      format.all { render :nothing => true, :status => 200 }
    end
  end

  def yo_layout
    @username = params[:username].to_s
    @yo = Yo.create(username: @username)

    respond_to do |format|
      format.html { render :layout => false }
    end
  end
end