module ApplicationHelper
  include Pagy::Frontend

  def display_average_rating(average_rating)
    if average_rating == average_rating.to_i
      average_rating.to_i
    else
      average_rating
    end
  end
end
