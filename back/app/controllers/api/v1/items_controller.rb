module Api
  module V1
    class ItemsController < ApplicationController
      before_action :authorize_access_request!
      before_action :set_item, only: [:show, :update, :destroy]

      def index
        @items = current_user.items.all

        render json: @items
      end

      def show
        render json: @item
      end

      def create
        @item = current_user.items.build(items_params)

        if @item.save
          render json: @item, status: :created
        else
          render json: @item.errors, status: :unprocessable_entity
        end
      end

      def update
        if @item.update(items_params)
          render json: @item
        else
          render json: @item.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @item.destroy
      end

      private
        def set_item
          @item = current_user.items.find(params[:id])
        end

        def items_params
          params.require(:item).permit(:title, :descripion, :completed)
        end
    end
  end
end