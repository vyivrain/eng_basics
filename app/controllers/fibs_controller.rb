class FibsController < ApplicationController
  before_action :set_fib, only: [:destroy]

  def new
    @fib = Fib.new
  end

  def destroy
    @fib.destroy
    redirect_to root_path, notice: I18n.t('fibs.destroy.success')
  end

  private

  def set_fib
    @fib = Fib.find_by(id: params[:id])
  end
end
