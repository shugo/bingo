class NumbersController < ApplicationController
  def index
    @numbers = Number.all
    respond_to do |format|
      format.html
      format.json { render json: { numbers: @numbers }.to_json }
    end
  end

  def create
    @numbers = Number.create
  end

  def destroy
    Number.clear
    @numbers = []
  end
end
