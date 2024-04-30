import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["link"];

  connect() {
    const currentPage = this.getCurrentPage();

    this.linkTargets.forEach(link => {
      if (link.dataset.navbarPage === currentPage) {
        link.classList.add("link-active");
      }
    });
  }

  getCurrentPage() {
    // Get the current URL path
    const path = window.location.pathname;

    // Extract the page name from the path
    const segments = path.split("/"); // Assuming the page name is the last segment of the path

    // Check if the path represents a user's page (/users/id)
    if (segments.length === 3 && segments[1] === "users" && segments[2]) {
    // Return a string indicating that this is a user's page
    return "user";
    }

    // If not a user's page, return the last segment of the path
    return segments.pop();
  }
}
