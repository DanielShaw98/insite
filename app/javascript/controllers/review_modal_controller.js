import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["modal", "form", "contentMessage", "ratingMessage"];

  // Method to toggle the visibility of the modal
  toggleModal(event) {
    this.modalTarget.style.display = this.modalTarget.style.display === "block" ? "none" : "block";
  }

  // Method to handle form submission
  submitForm(event) {
    event.preventDefault(); // Prevent default form submission

    // Fetch form data
    const formData = new FormData(this.formTarget);

    // Send form data to the server using fetch
    fetch(this.formTarget.action, {
      method: this.formTarget.method,
      body: formData,
      headers: {
        Accept: "application/json"
      }
    })
      .then(response => {
        if (!response.ok) {
          throw new Error("Network response was not ok");
        }
        return response.json();
      })
      .then(data => {
        // Check if the server returned validation errors
        if (data.errors) {
          // Display error messages
          this.displayErrors(data.errors);
          // Shake error message elements
          this.shakeErrorMessages();
        } else {
          // Handle successful form submission
          // Close review modal
          this.toggleModal();
        }
      })
      .catch(error => {
        console.error("Error:", error);
        // Handle error - for example, display a generic error message
        this.displayErrors(error);
        // Shake error message elements
        this.shakeErrorMessages();
      });
  }

  ratingError() {
    const formData = new FormData(this.formTarget);
    const ratingValue = formData.get("review[rating]");
    if (ratingValue === '') {
      this.errorMessage(this.ratingMessageTarget, "Rating cannot be blank.");
    } else if (ratingValue < 1 || ratingValue > 5) {
      this.errorMessage(this.ratingMessageTarget, "Rating must be between 1 and 5.");
    } else {
      this.successMessage(this.ratingMessageTarget);
    }
  }

  contentError() {
    const formData = new FormData(this.formTarget);
    const contentValue = formData.get("review[content]");
    if (contentValue === '') {
      this.errorMessage(this.contentMessageTarget, "Content cannot be blank.");
    } else if (contentValue.split(" ").length < 20) {
      this.errorMessage(this.contentMessageTarget, "Content must be at least 20 words long.");
    } else if (contentValue.split(" ").length > 300) {
      this.errorMessage(this.contentMessageTarget, "Content must be at most 300 words long.");
    } else {
      this.successMessage(this.contentMessageTarget);
    }
  }

  // Method to display error messages
  displayErrors(errors) {
    this.ratingError();
    this.contentError();
  }

  // Method to set error message
  errorMessage(target, message) {
    target.textContent = message;
    target.classList.add("review-error-message");
  }

  // Method to set success message
  successMessage(target) {
    target.textContent = "";
    target.classList.remove("review-error-message");
  }

  // Method to shake error message elements
  shakeErrorMessages() {
    this.contentMessageTargets.forEach(target => {
      target.classList.add("shake-animation");
      setTimeout(() => {
        target.classList.remove("shake-animation");
      }, 500); // Duration of the shake animation in milliseconds
    });
    this.ratingMessageTargets.forEach(target => {
      target.classList.add("shake-animation");
      setTimeout(() => {
        target.classList.remove("shake-animation");
      }, 500); // Duration of the shake animation in milliseconds
    });
  }
}
