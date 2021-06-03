module Api
  module V1
    class ItemsController < ApplicationController
      before_action :authorize_access_request!
      before_action :set_item, only: [:show, :update, :destroy]

      def index
        @items = current_user.items.order(order: :asc)

        render_success({items: @items})
      end

      def show
        render json: @item
      end

      def create
        @item = current_user.items.build(items_params)

        if @item.save
          render_success({
            item: @item,
            message: I18n.t('api_success.items_created')
          })
        else
          render_unprocessable_entity_error(@item.errors.full_messages.join(' '))
        end
      end

      def update
        if @item.update(items_params)
          render_success({
            item: @item,
            message: I18n.t('api_success.items_updated')
          })
        else
          render_unprocessable_entity_error(@item.errors.full_messages.join(' '))
        end
      end

      def reorder
        if reorder_items_params[:items].blank?
          render_unprocessable_entity_error(I18n.t('api_errors.empty_reorder_list'))
        else
          reorder_items_params[:items].each {|obj| current_user.items.find(obj[:id]).update(order: obj[:order])}
          
          @items = current_user.items.order(order: :asc)

          render_success({
            items: @items,
            message: I18n.t('api_success.items_reordered')
          })
        end
      end

      def destroy
        if @item.destroy

          items = current_user.items.order(order: :asc)

          render_success({
            items: items,
            message: I18n.t('api_success.item_deleted')
          })
        else
          render_unprocessable_entity_error(@item.errors.full_messages.join(' '))
        end
      end

      private
        def set_item
          @item = current_user.items.find_by(id: params[:id])
          render_not_found_error(I18n.t('api_errors.render_not_found', class: 'Item')) if @item.blank?
        end

        def items_params
          params.require(:item).permit(:title, :completed, :order)
        end

        def reorder_items_params
          params.permit(items: [:id, :order])
        end
    end
  end
end