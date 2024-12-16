import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["container", "showMoreButton"];
  static values = { url: String, offset: Number };

  async showMore() {
    try {
        const response = await fetch(`${this.urlValue}?offset=${this.offsetValue}`, {
            method: 'GET',
            headers: {
                'Accept': 'application/json'
            }
        });

        if (!response.ok) {
            throw new Error('Failed to fetch reviews');
        }

        const data = await response.json();

        data.reviews.forEach(review => {
        const reviewElement = document.createElement('div');
        reviewElement.classList.add('video-review');

        const dateOptions = { year: '2-digit', month: '2-digit', day: '2-digit' };
        const formattedDate = new Date(review.created_at).toLocaleDateString('en-GB', dateOptions);

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

        this.containerTarget.appendChild(reviewElement);
        });

        if (!data.has_more) {
            this.showMoreButtonTarget.style.display = "none";
        }

        this.offsetValue += 3;
    } catch (error) {
        console.error("Error fetching reviews:", error);
    }
  }
}
