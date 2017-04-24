class OwnershipsController < ApplicationController
  def create
    @item = Item.find_or_initialize_by(code: params[:item_code])

    unless @item.persisted?
      results = RakutenWebService::Ichiba::Item.search(itemCode: @item.code)
      @item = Item.new(read(results.first))
      @item.save
    end

    if params[:type] == "Want"
      current_user.want(@item)
      flash[:success] = "Add the itme to Want"
    end

    if params[:type] == "Hav"
      current_user.hav(@item)
      flash[:success] = "Add the itme to Have"
    end

    redirect_back(fallback_location: root_path)
  end

  def destroy
    @item = Item.find(params[:item_id])
    
    if params[:type] == "Want"
      current_user.unwant(@item)
      flash[:success] = "Remove the item from Want"
    end
    
    if params[:type] == "Hav"
      current_user.unhav(@item)
      flash[:success] = "Remove the item from Have"
    end

    redirect_back(fallback_location: root_path)
  end

end
