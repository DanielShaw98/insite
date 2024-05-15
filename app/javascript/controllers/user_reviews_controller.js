import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["reviewsModal", "rating", "container", "showMoreButton"];
  static values = { url: String, offset: Number };

  toggleModal(event) {
    this.reviewsModalTarget.style.display = this.reviewsModalTarget.style.display === "block" ? "none" : "block";
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
        reviewElement.classList.add('video-review');

        const dateOptions = { year: '2-digit', month: '2-digit', day: '2-digit' };
        const formattedDate = new Date(review.created_at).toLocaleDateString('en-GB', dateOptions);

        // Create the inner HTML for the review element
        reviewElement.innerHTML = `
          <div class="video-review-user-info">
            <div class="video-review-username-date">
              <div class="video-review-username">${review.user.username}</div>
              <div class="video-review-date">${formattedDate}</div>
            </div>
              <div class="video-review-avatar">
                <img src="${review.user.avatar_image_url}" alt="User Avatar">
              </div>
          </div>
          <div class="video-review-rating-info">
            <div class="video-review-rating">${review.rating}</div>
            <div data-controller="rating" data-rating="${review.rating}" class="rating">
                <div class="stars" data-rating-target="rating"></div>
            </div>
          </div>
          <div class="video-review-content">${review.content}</div>
          `;

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
