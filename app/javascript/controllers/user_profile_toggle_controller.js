import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["title"];

  async fetchAndRenderPartial(url, container) {
    const response = await fetch(url);
    const html = await response.text();
    container.innerHTML = html;
  }

  initialize() {
    const purchasesTitle = this.titleTargets.find(title => title.id === "user-profile-purchases");
    const selectedTab = localStorage.getItem("selectedTab");
    const selectedTitle = this.titleTargets.find(title => title.id === selectedTab);
    if (selectedTitle) {
      this.toggle({ target: selectedTitle });
    } else {
      this.toggle({ target: purchasesTitle });
    }
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
            localStorage.setItem("selectedTab", id);
            title.classList.remove("user-title-purchases");
            title.classList.add("purchases-focus");
            this.fetchAndRenderPartial(`/users/${userId}/purchases`, document.getElementById("partial-container"));
            break;
          case "user-profile-followings":
            localStorage.setItem("selectedTab", id);
            title.classList.remove("user-title-followings");
            title.classList.add("followings-focus");
            this.fetchAndRenderPartial(`/users/${userId}/followings`, document.getElementById("partial-container"));
            break;
          case "user-profile-pledges":
            localStorage.setItem("selectedTab", id);
            title.classList.remove("user-title-pledges");
            title.classList.add("pledges-focus");
            this.fetchAndRenderPartial(`/users/${userId}/pledges`, document.getElementById("partial-container"));
            break;
          case "user-profile-reviews":
            localStorage.setItem("selectedTab", id);
            title.classList.remove("user-title-reviews");
            title.classList.add("reviews-focus");
            this.fetchAndRenderPartial(`/users/${userId}/reviews`, document.getElementById("partial-container"));
            break;
          default:
            break;
        }
        titles.forEach(otherTitle => {
          if (otherTitle !== clickedTitle) {
            otherTitle.classList.remove("purchases-focus", "followings-focus", "pledges-focus", "reviews-focus");
            const otherId = otherTitle.id;
            const className = otherId.replace("user-profile-", "");
            otherTitle.classList.add("user-title-" + className);
          }
        });
      }
    });
  }
}
