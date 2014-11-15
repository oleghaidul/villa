class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  respond_to :html

  before_action :set_locale, :set_search

  def set_locale
    if params[:locale] && I18n.available_locales.include?(params[:locale].to_sym)
      cookies['locale'] = { value: params[:locale], expires: 1.year.from_now }
      I18n.locale = params[:locale].to_sym
    elsif cookies['locale'] && I18n.available_locales.include?(cookies['locale'].to_sym)
      I18n.locale = cookies['locale'].to_sym
    end
  end

  def set_search
    params[:q] ||= {}
    params[:q][:rental_eq] ||= true if params[:q][:rental_eq].blank? && params[:q][:sale_eq].blank?
    @q = Villa.search(params[:q])
    @villas = @q.result(distinct: true).page(params[:page])
    @phuket = true
  end
end
