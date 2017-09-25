module Api
  module V1
    class FibsController < BaseController
      before_action :set_fib, except: [:index, :create]

      def index
        render json: Fib.all
      end

      def show
        render json: @fib
      end

      def create
        @fib = Fib.new(fib_params)
        if @fib.save
          render json: { message: I18n.t('fibs.create.success'), status: 'success' }
        else
          render json: { message:  @fib.errors.full_messages, status: 'danger' }
        end
      end

      def check_item_exist
        if @fib.is_known_fib?(fib_item_exist_params[:number])
          render json: { message: I18n.t('fibs.check_items_exist.success'), status: 'success' }
        else
          render json: { message: I18n.t('fibs.check_items_exist.error'), status: 'danger' }
        end
      end

      def check_items_equality
        if @fib.all_fibs?(fib_list_equality_params[:list])
          render json: { message: I18n.t('fibs.check_items_equality.success'), status: 'success' }
        else
          render json: { message: I18n.t('fibs.check_items_equality.error'), status: 'danger' }
        end
      end

      private

      def set_fib
        @fib = Fib.find_by(id: params[:id])
        render json: { message: 'Fib Not Found' } if @fib.blank?
      end

      def fib_item_exist_params
        params.require(:fib).permit(:number)
      end

      def fib_list_equality_params
        params.require(:fib).permit(:list)
      end

      def fib_params
        { items: FibsService.new.generate(params[:fib][:number].to_i) }
      end
    end
  end
end
