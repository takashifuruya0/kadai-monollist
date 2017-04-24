class ItemsController < ApplicationController
  before_action :require_user_logged_in

  def new
    @items = []

    @keyword = params[:keyword]
    if @keyword
      results = RakutenWebService::Ichiba::Item.search({
      #results = RakutenWebService::Ichiba::Item.search({keyword: 'ruby', imageFlag: 1, hits: 1})
        keyword: @keyword,
        imageFlag: 1,
        hits: 20,
      })

      results.each do |result|
        item = Item.new(read(result))
        @items << item
      end
    end
  end

  def show
    @item.find(params[:id])
    @want_users = @item.want_users
  end
end
