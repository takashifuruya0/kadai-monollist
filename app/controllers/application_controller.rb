class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper

  private

  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end

  private 

  def read(result)
    code = result.code
    name = result.name
    url = result.url
    image_url = result["mediumImageUrls"].first["imageUrl"].gsub("?_ex=128x128","")
    return {
      code: code,
      name: name,
      url: url,
      image_url: image_url,
    }
  end
end
