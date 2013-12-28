class VillasController < ApplicationController
  before_action :set_filters

  def index
    params[:q][:area_id_place_eq] ||= Area.where(name: 'Phuket').first.id
    @q = Villa.for_rent.search(params[:q])
    @villas = @q.result(distinct: true)
    @areas = Area.for_rent.roots
    @recent_villas = Villa.recent.for_rent.limit(4)
    @phuket = true
    @phuket_areas = Area.phuket
  end

  def sales
    params[:q][:area_id_place_eq] ||= Area.where(name: 'Phuket').first.id
    @q = Villa.for_sale.search(params[:q])
    @villas = @q.result(distinct: true)
    @areas = Area.for_sale.roots
    @recent_villas = Villa.recent.for_sale.limit(4)
    @phuket = true
    @phuket_areas = Area.phuket
  end

  def yacht_rentals
    @q = Villa.yacht_rentals.search(params[:q])
    @villas = @q.result(distinct: true)
    @areas = Area.roots
    @recent_villas = Villa.recent.yacht_rentals.limit(4)
  end

  def car_rentals
    @q = Villa.car_rentals.search(params[:q])
    @villas = @q.result(distinct: true)
    @areas = Area.roots
    @recent_villas = Villa.recent.car_rentals.limit(4)
  end

  def real_estate_rentals
    @q = Villa.search(params[:q])
    @villas = @q.result(distinct: true)
    @areas = Area.for_rent.roots
    @recent_villas = Villa.recent.for_sale.limit(4)
  end

  def real_estate_sales
    @q = Villa.search(params[:q])
    @villas = @q.result(distinct: true)
    @areas = Area.for_sale.roots
    @recent_villas = Villa.recent.for_sale.limit(4)
  end

  def show
    @villa = Villa.find(params[:id])
    @request = @villa.requests.build
  end

  private

    def set_filters
      params[:q] ||= {}
      params[:q][:bedrooms_gteq] ||= 1
      params[:q][:bedrooms_gteq] ||= 10
      params[:q][:price_from_gteq] ||= 0
      params[:q][:price_from_lteq] ||= 7000
    end
end
