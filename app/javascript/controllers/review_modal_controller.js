import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["outerModal", "innerModal", "form", "contentMessage", "ratingMessage"];

  connect() {
    const showOuterModal = localStorage.getItem("showOuterModal");
    if (showOuterModal === "true") {
      // Toggle outer modal
      this.toggleOuterModal();
      // Clear the stored modal state
      localStorage.removeItem("showOuterModal");
    }
  }

  // Method to toggle the visibility of the outer modal
  toggleOuterModal(event) {
    this.outerModalTarget.style.display = this.outerModalTarget.style.display === "block" ? "none" : "block";
  }

  // Method to toggle the visibility of the inner modal
  toggleInnerModal(event) {
    // Prevent event propagation to avoid closing the outer modal when clicking inside the inner modal
    this.innerModalTarget.style.display = this.innerModalTarget.style.display === "block" ? "none" : "block";
  }

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
          if (response.status === 422) {
            throw new Error("You have already left a review for this guide.");
          } else {
            throw new Error("Network response was not ok.");
          }
        }
        return response.json();
      })
      .then(data => {
        // Handle successful form submission
        // Store modal state before page reloads
        localStorage.setItem('showOuterModal', 'true');
        // Refresh the page
        window.location.reload();
      })
      .catch(error => {
        console.error("Error:", error);
        // Handle errors
        if (error.message === "You have already left a review for this guide.") {
          this.displayErrors({ error: error.message });
        } else {
          this.displayErrors({ error: "An unexpected error occurred. Please try again later." });
        }
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

  contentError(data) {
    const formData = new FormData(this.formTarget);
    const contentValue = formData.get("review[content]");
    if (contentValue === '') {
      this.errorMessage(this.contentMessageTarget, "Content cannot be blank.");
    } else if (contentValue.split(" ").length < 20) {
      this.errorMessage(this.contentMessageTarget, "Content must be at least 20 words long.");
    } else if (contentValue.split(" ").length > 300) {
      this.errorMessage(this.contentMessageTarget, "Content must be at most 300 words long.");
    } else if (data.error) {
      this.errorMessage(this.contentMessageTarget, data.error);
    } else {
      this.successMessage(this.contentMessageTarget);
    }
  }

  // Method to display error messages
  displayErrors(data) {
    this.ratingError();
    this.contentError(data);
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
