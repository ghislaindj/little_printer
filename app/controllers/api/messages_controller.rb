class Api::MessagesController < ApplicationController
  respond_to :json

  def index
    @messages = Message.all

    # respond_to do |format|
    #   format.json { render json: @messages }
    # end
  end

  def new
    @message = Message.new

    respond_to do |format|
      format.json { render json: @message }
    end
  end

  def create
    @message = Message.create message_params

    respond_to do |format|
    end
  end

  private
  def message_params
    params.permit(:title, :text, :username)
  end
end