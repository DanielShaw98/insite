import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["title"];

  toggle(event) {
    // Remove the 'active' class from all title elements
    this.titleTargets.forEach(title => {
      title.classList.remove('active');
    });

    // Add the 'active' class to the clicked title element
    event.currentTarget.classList.add('active');

    // Call a function to render data based on the selected title
    this.renderData(event.currentTarget.textContent);
  }

  renderData(selectedTitle) {
    // You can implement logic here to render different data based on the selected title
  }
}
