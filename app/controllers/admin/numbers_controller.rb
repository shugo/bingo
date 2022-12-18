class Admin::NumbersController < AdminController
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
end
