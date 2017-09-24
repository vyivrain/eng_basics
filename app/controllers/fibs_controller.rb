class FibsController < ApplicationController
  before_action :set_fib, only: [:show, :update, :destroy, :check_item_exist, :check_items_equality]

  def index
    @fibs = Fib.all
  end

  def show
  end

  def new
    @fib = Fib.new
  end

  def create
    @fib = Fib.new(fib_params)
    if @fib.save
      redirect_to @fib, notice: I18n.t('fibs.create.success')
    else
      flash.now[:error] = @fib.errors.full_messages
      render :new
    end
  end

  def destroy
    @fib.destroy
    redirect_to root_path, notice: I18n.t('fibs.destroy.success')
  end

  def check_item_exist
    if @fib.is_known_fib?(fib_item_exist_params[:number])
      flash[:success] = I18n.t('fibs.check_items_exist.success')
    else
      flash[:error] = I18n.t('fibs.check_items_exist.error')
    end
    redirect_to @fib
  end

  def check_items_equality
    if @fib.all_fibs?(fib_list_equality_params[:list])
      flash[:success] = I18n.t('fibs.check_items_equality.success')
    else
      flash[:error] = I18n.t('fibs.check_items_equality.error')
    end
    redirect_to @fib
  end

  private

  def set_fib
    @fib = Fib.find_by(id: params[:id])
    redirect_to(root_path) if @fib.blank?
  end

  def fib_params
    { items: FibsService.new.generate(params[:fib][:number].to_i) }
  end

  def fib_item_exist_params
    params.require(:fib).permit(:number)
  end

  def fib_list_equality_params
    params.require(:fib).permit(:list)
  end
end
