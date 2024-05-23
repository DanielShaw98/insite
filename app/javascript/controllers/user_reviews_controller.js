import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["reviewsModal", "ratingVideo", "ratingReview", "container", "showMoreButton"];
  static values = { url: String, offset: Number };

  connect() {
    this.adjustRatings();
    // Check if the modal was open before refreshing the page
    const modalOpen = localStorage.getItem("reviewModalOpen");
    if (modalOpen === "true") {
      this.reviewsModalTarget.style.display = "block";
    }
  }

  toggleModal(event) {
    const isOpen = this.reviewsModalTarget.style.display === "block";
    if (!isOpen) {
      localStorage.setItem("reviewModalOpen", "true");
    } else {
      localStorage.removeItem("reviewModalOpen");
    }
    this.reviewsModalTarget.style.display = isOpen ? "none" : "block";
  }

  adjustRatings() {
    this.ratingVideoTargets.forEach(target => {
      const rating = parseFloat(target.dataset.rating);
      const width = Math.round((rating / 5) * 60);
      if (width > 0) {
        target.style.width = `${width}px`;
      }
    });

    this.ratingReviewTargets.forEach(target => {
      const rating = parseFloat(target.dataset.rating);
      const width = Math.round((rating / 5) * 80);
      if (width > 0) {
        target.style.width = `${width}px`;
      }
    });
  }

  async showMore() {
    try {
        const response = await fetch(`${this.urlValue}?offset=${this.offsetValue}`, {
            method: 'GET',
            headers: {
                'Accept': 'application/json' // Specify the desired response format
            }
        });

        if (!response.ok) {
            throw new Error('Failed to fetch reviews');
        }

        const data = await response.json();

        // Iterate over each review in the JSON response and create HTML elements
        data.reviews.forEach(review => {
        // Create a div element for the review
        const reviewElement = document.createElement('div');
        reviewElement.classList.add('user-video-review-container');

        const dateOptions = { year: '2-digit', month: '2-digit', day: '2-digit' };
        const formattedDate = new Date(review.created_at).toLocaleDateString('en-GB', dateOptions);

        // Create the inner HTML for the review element
        reviewElement.innerHTML = `
          <div class="review-video-card">
            <a href="/videos/${review.video.id}">
              <div class="video-thumbnail">
                <img src="${review.video.thumbnail_url}" alt="Video Thumbnail">
              </div>
              <div class="video-info">
                <div class="review-video-title">${review.video.title}</div>
                <div class="review-video-creator">${review.video.creator.user.username}</div>
                <div class="review-video-rating">${review.video.average_rating}
                  <div data-controller="rating" data-rating="${review.video.average_rating}" class="rating">
                    <div class="review-stars" data-rating-target="rating"></div>
                  </div>
                </div>
              </div>
            </a>
          </div>
          <div class="video-review">
            <div class="video-review-user-info">
              <div class="video-review-username-date">
                <div class="video-review-username">${review.user.username}</div>
                <div class="video-review-date">${formattedDate}</div>
              </div>
              <form action="/videos/${review.video.id}/reviews/${review.id}" method="post" class="user-review-delete-form">
                <input type="hidden" name="_method" value="delete">
                <input type="hidden" name="authenticity_token" value="<%= form_authenticity_token %>">
                <button type="submit" class="user-review-delete"></button>
              </form>
            </div>
            <div class="video-review-rating-info">
              <div class="video-review-rating">${review.rating}</div>
              <div data-controller="rating" data-rating="${review.rating}" class="rating">
                <div class="stars" data-rating-target="rating"></div>
              </div>
            </div>
            <div class="video-review-content">${review.content}</div>
            </div>`;

        // Append the review element to the container
        this.containerTarget.appendChild(reviewElement);
        });

        // Hide the "Show More" button if there are no more reviews to load
        if (!data.has_more) {
            this.showMoreButtonTarget.style.display = "none";
        }

        // Increment offset value for the next request
        this.offsetValue += 3;
    } catch (error) {
        console.error("Error fetching reviews:", error);
    }
  }
}
