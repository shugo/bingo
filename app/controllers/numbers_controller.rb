class NumbersController < ApplicationController
  before_action :basic_auth, except: :selected

  def index
    @numbers = Number.all
  end

  def create
    @numbers = Number.create
  end

  def destroy
    Number.clear
    @numbers = []
  end

  def selected
    render json: { numbers: Number.all }.to_json
  end

  private

  def basic_auth
    return if ENV["BASIC_AUTH_USER"].blank?
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end    
  end
end
