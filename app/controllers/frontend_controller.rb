class FrontendController < ApplicationController
  layout proc{|c| c.request.xhr? ? false : 'application' }

  def index

  end

  def profile

  end

  def template
    render template: "templates/#{params[:name]}",layout: false
  end

end
