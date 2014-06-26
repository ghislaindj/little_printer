class Backoffice::YosController < Backoffice::BaseController

  # GET /backoffice/yos
  def index
    @all_yos = Yo.all
    @yos = Yo.where(:printed_at.exists => true).order('PRINTED_AT DESC')
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @yos }
    end
  end
end