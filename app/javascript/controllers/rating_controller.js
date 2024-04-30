import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["rating"];

  connect() {
    this.adjustRating();
  }

  adjustRating() {
    const rating = parseFloat(this.element.dataset.rating);
    const width = Math.round((rating / 5) * this.element.offsetWidth);
    if (width > 0) {
      this.ratingTarget.style.width = `${width}px`;
    }
  }
}
