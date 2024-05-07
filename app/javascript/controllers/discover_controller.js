import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["form", "videosContainer"];

  submitForm(event) {
    event.preventDefault(); // Prevent default form submission

    // Fetch form data
    const formData = new FormData(this.formTarget);

    // Serialize form data
    const params = new URLSearchParams(formData).toString();

    // Perform AJAX request to the 'filter' action
    fetch(this.formTarget.action + "?" + params, {
      method: "GET",
      headers: {
        "X-Requested-With": "XMLHttpRequest",
        "Accept": "application/json"
      }
    })
    .then(response => response.json())
    .then(data => {
      this.videosContainerTarget.innerHTML = data.html;
    })
    .catch(error => {
      console.error("Error:", error);
      // Handle errors
    });
  }
}
