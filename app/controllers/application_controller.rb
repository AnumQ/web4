class ApplicationController < ActionController::Base
  #before_filter :authorize_admin
  protect_from_forgery
  before_filter :initialize_cart
  
  private   	
    def current_cart
		Cart.find(session[:cart_id])
	rescue ActiveRecord::RecordNotFound
		cart = Cart.create
		session[:cart_id] = cart.id
		cart
	end

	def verify_is_admin
  (current_user.nil?) ? redirect_to(root_path) : (redirect_to(root_path) unless current_user.admin?)
	end

  protected
  	def initialize_cart
  		Cart.find(session[:cart_id])
		rescue ActiveRecord::RecordNotFound
		cart = Cart.create
		session[:cart_id] = cart.id
		cart
  	end

 	def authorize
	  unless user_signed_in?
	  	redirect_to login_path, :method => :get, :notice => "Please login"
	  end
	end

	def authorize_admin
	  unless current_user.admin?
	  	redirect_to store_url, :notice => "You don't have the permissions."
	  end
    end

private


end
