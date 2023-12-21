class Admin::NumbersController < AdminController
  def index
    if request.from_smartphone?
      request.variant = :mobile
    end
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
