class HomeController < ApplicationController
  def index
  end

  def about
  end

  def contact
  end
  
  def send_to
    flash[:notice] = "Your message has been sent successfully."
    redirect_to action: 'index'
  end
end
