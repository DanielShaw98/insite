import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["pledgesModal", "showMoreButton", "container"];

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
}
