import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["pledgesModal", "showMoreButton", "container"];
  static values = { url: String, offset: Number };

  connect() {
    // Check if the modal was open before refreshing the page
    const modalOpen = localStorage.getItem("pledgeModalOpen");
    if (modalOpen === "true") {
      this.pledgesModalTarget.style.display = "block";
    }
  }

  toggleModal(event) {
    const isOpen = this.pledgesModalTarget.style.display === "block";
    if (!isOpen) {
      localStorage.setItem("pledgeModalOpen", "true");
    } else {
      localStorage.removeItem("pledgeModalOpen");
    }
    this.pledgesModalTarget.style.display = isOpen ? "none" : "block";
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
            throw new Error('Failed to fetch pledges');
        }

        const data = await response.json();

        // Iterate over each review in the JSON response and create HTML elements
        data.pledges.forEach(pledge => {
        // Create a div element for the review
        const pledgeElement = document.createElement('div');
        pledgeElement.classList.add('pledge-creator-card-container');

        const dateOptions = { year: '2-digit', month: '2-digit', day: '2-digit' };
        const formattedDate = new Date(pledge.created_at).toLocaleDateString('en-GB', dateOptions);

        // Create the inner HTML for the review element
        pledgeElement.innerHTML = `
          <div class="pledge-creator-card">
            <a href="/creators/${pledge.creator.id}">
              <div class="pledge-creator-avatar">
                <img src="${pledge.creator.user.avatar_image_url}" alt="Creator Avatar">
              </div>
              <div class="creator-card-info">
                <div class="pledge-creator-username">${pledge.creator.user.username}</div>
                <div class="pledge-creator-specialisation">${pledge.creator.specialisation}</div>
              </div>
            </a>
          </div>
          <div class="user-pledge-container">
            <div class="user-pledge">
              <div class="user-pledge-user-info">
                <div class="pledge-username-date">
                <div class="pledge-username">${pledge.user.username}</div>
                <div class="pledge-date">${formattedDate}</div>
              </div>
              <form action="/pledges/${pledge.id}" method="post" class="user-pledge-delete-form">
                <input type="hidden" name="_method" value="delete">
                <input type="hidden" name="authenticity_token" value="<%= form_authenticity_token %>">
                <button type="submit" class="user-pledge-delete"></button>
              </form>
            </div>
            <div class="pledge-votes-info">
              <div class="pledge-votes">${pledge.votes} Up-Votes</div>
            </div>
            <div class="pledge-content">${pledge.content}</div>
          </div>
        </div>`;

        // Append the review element to the container
        this.containerTarget.appendChild(pledgeElement);
        });

        // Hide the "Show More" button if there are no more reviews to load
        if (!data.has_more) {
            this.showMoreButtonTarget.style.display = "none";
        }

        // Increment offset value for the next request
        this.offsetValue += 3;
    } catch (error) {
        console.error("Error fetching pledges:", error);
    }
  }
}
