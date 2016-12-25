class FrontendController < ApplicationController
  layout proc{|c| c.request.xhr? ? false : 'application' }

  def index

  end

  def profile

  end
  def shop
    
  end

  def template
    super
  end

end
