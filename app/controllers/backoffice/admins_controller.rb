class Backoffice::AdminsController < Backoffice::BaseController

  # GET /backoffice/admins
  # GET /backoffice/admins.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admins }
    end
  end

  # GET /backoffice/admins/new
  # GET /backoffice/admins/new.json
  def new
    @admin = Admin.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin }
      format.js
    end
  end

  # POST /backoffice/admins
  # POST /backoffice/admins.json
  def create
    @admin = Admin.new(admin_params)

    respond_to do |format|
      if @admin.save
        format.html { redirect_to @admin, notice: 'Admin was successfully created.' }
        format.json { render json: @admin, status: :created, location: @admin }
        format.js 
      else
        format.html { render action: "new" }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /backoffice/admins/1
  # DELETE /backoffice/admins/1.json
  def destroy
    @admin = Admin.find(params[:id])
    @admin.destroy

    respond_to do |format|
      format.html { redirect_to backoffice_admins_url }
      format.js { 
        render :delete 
      }
    end
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_params
    params.require(:admin).permit(:email, :password)
  end
end
