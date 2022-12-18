class CardController < ApplicationController
  def show
    @seed = session[:seed] ||= SecureRandom.rand(0xFFFFFFFF)
  end
end
