import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["title"];

  async fetchAndRenderPartial(url, container) {
    const response = await fetch(url);
    const html = await response.text();
    container.innerHTML = html;
  }

  toggle(event) {
    const clickedTitle = event.target;
    const titles = this.titleTargets;
    const userId = this.element.dataset.userId;

    titles.forEach(title => {
      if (title === clickedTitle) {
        const id = title.id;
        switch (id) {
          case "user-profile-purchases":
            title.classList.remove("user-title-purchases");
            title.classList.add("purchases-focus");
            this.fetchAndRenderPartial(`/users/${userId}/purchases`, document.getElementById("partial-container"));
            break;
          case "user-profile-subscriptions":
            title.classList.remove("user-title-subscriptions");
            title.classList.add("subscriptions-focus");
            this.fetchAndRenderPartial(`/users/${userId}/subscriptions`, document.getElementById("partial-container"));
            break;
          case "user-profile-pledges":
            title.classList.remove("user-title-pledges");
            title.classList.add("pledges-focus");
            this.fetchAndRenderPartial(`/users/${userId}/pledges`, document.getElementById("partial-container"));
            break;
          case "user-profile-reviews":
            title.classList.remove("user-title-reviews");
            title.classList.add("reviews-focus");
            this.fetchAndRenderPartial(`/users/${userId}/reviews`, document.getElementById("partial-container"));
            break;
          default:
            break;
        }
        titles.forEach(otherTitle => {
          if (otherTitle !== clickedTitle) {
            otherTitle.classList.remove("purchases-focus", "subscriptions-focus", "pledges-focus", "reviews-focus");
            const otherId = otherTitle.id;
            const className = otherId.replace("user-profile-", "");
            otherTitle.classList.add("user-title-" + className);
          }
        });
      }
    });
  }
}
