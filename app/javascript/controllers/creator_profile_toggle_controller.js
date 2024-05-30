import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["title"];

  async fetchAndRenderPartial(url, container) {
    const response = await fetch(url);
    const html = await response.text();
    container.innerHTML = html;
  }

  initialize() {
    const coursesTitle = this.titleTargets.find(title => title.id === "creator-profile-courses");
    const selectedTab = localStorage.getItem("selectedTab");
    const selectedTitle = this.titleTargets.find(title => title.id === selectedTab);
    if (selectedTitle) {
      this.toggle({ target: selectedTitle });
    } else {
      this.toggle({ target: coursesTitle });
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
          case "creator-profile-courses":
            localStorage.setItem("selectedTab", id);
            title.classList.remove("creator-title-courses");
            title.classList.add("courses-focus");
            this.fetchAndRenderPartial(`/users/${userId}/videos`, document.getElementById("partial-container"));
            break;
          case "creator-profile-pledges":
            localStorage.setItem("selectedTab", id);
            title.classList.remove("creator-title-pledges");
            title.classList.add("pledges-focus");
            this.fetchAndRenderPartial(`/users/${userId}/pledges`, document.getElementById("partial-container"));
            break;
          default:
            break;
        }
        titles.forEach(otherTitle => {
          if (otherTitle !== clickedTitle) {
            otherTitle.classList.remove("courses-focus", "pledges-focus");
            const otherId = otherTitle.id;
            const className = otherId.replace("creator-profile-", "");
            otherTitle.classList.add("creator-title-" + className);
          }
        });
      }
    });
  }
}
