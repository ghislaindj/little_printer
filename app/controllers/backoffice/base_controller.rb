class Backoffice::BaseController < ApplicationController
  before_filter :authenticate_admin!
  layout 'backoffice'
end