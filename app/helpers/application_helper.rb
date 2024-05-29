module ApplicationHelper
  include Pagy::Frontend

  def display_average_rating(average_rating)
    if average_rating == average_rating.to_i
      average_rating.to_i
    else
      average_rating
    end
  end

  def user_avatar(user, html_options = {})
    image_tag user.avatar_image_url, html_options
  end
end
