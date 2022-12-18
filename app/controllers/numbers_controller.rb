class NumbersController < ApplicationController
  def index
    render json: { numbers: Number.all }.to_json
  end
end
