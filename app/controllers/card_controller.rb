class CardController < ApplicationController
  def show
    @seed = session[:seed] ||= Time.now.to_i
  end
end
