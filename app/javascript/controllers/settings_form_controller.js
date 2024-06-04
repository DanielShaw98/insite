import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["usernameField", "passwordField", "passwordConfirmationField", "avatarField", "successMessage", "errorMessage"];
  bypassValidation = false; // Flag to control when to bypass validation

  connect() {
    this.clearMessages();
  }

  validateUsername(event) {
    event.preventDefault(); // Prevent form from submitting immediately

    if (this.bypassValidation) {
      event.target.submit(); // Submit without validation if flag is true
      return; // Exit the function
    }

    const usernameValue = this.usernameFieldTarget.value.trim();
    const currentUsername = this.usernameFieldTarget.dataset.currentUsername.trim();

    if (usernameValue === "") {
      this.displayErrorMessage("Username cannot be blank.");
      return;
    }

    if (usernameValue === currentUsername) {
      this.displayErrorMessage("New username cannot be the same as the current username.");
      return;
    }

    this.checkUsernameAvailability(usernameValue, event.target);
  }

  checkUsernameAvailability(username, form) {
    fetch(`/check_username_availability?username=${username}`, {
        headers: { "Accept": "application/json" }
    })
    .then(response => response.json())
    .then(data => {
        if (!data.available) {
            this.displayErrorMessage("This username is already taken.");
        } else {
            this.displaySuccessMessage("Username is available.");
            this.bypassValidation = true; // Set the flag to true to bypass validation on resubmit
            form.requestSubmit(); // Use requestSubmit to programmatically submit the form
        }
    }).catch(error => {
        console.error("Error checking username:", error);
        this.displayErrorMessage("Error checking username availability.");
    });
  }

  validatePassword(event) {
    event.preventDefault();
    const password = this.passwordFieldTarget.value;
    let messages = [];

    if (password.length < 8) {
      messages.push("Password must be at least 8 characters long.");
    }
    if (!/[A-Z]/.test(password)) {
      messages.push("Password must include at least one uppercase letter.");
    }
    if (!/\d/.test(password)) {
      messages.push("Password must include at least one number.");
    }
    if (!/[^A-Za-z0-9]/.test(password)) {
      messages.push("Password must include at least one special character.");
    }

    if (messages.length > 0) {
      this.displayErrorMessage(messages.join(" "));
    } else {
      this.displaySuccessMessage("Password successfully changed.");
    }
  }

  clearFieldError() {
    if (this.hasErrorMessageTarget) {
      this.errorMessageTarget.textContent = '';
      this.errorMessageTarget.classList.add('settings-hidden');
    }
    if (this.hasSuccessMessageTarget) {
      this.successMessageTarget.textContent = '';
      this.successMessageTarget.classList.add('settings-hidden');
    }
  }

  displayErrorMessage(message) {
    this.errorMessageTarget.textContent = message;
    this.errorMessageTarget.classList.remove("settings-hidden");
    this.successMessageTarget.classList.add("settings-hidden");
  }

  displaySuccessMessage(message) {
    this.successMessageTarget.textContent = message;
    this.successMessageTarget.classList.remove("settings-hidden");
    this.errorMessageTarget.classList.add("settings-hidden");
  }

  clearMessages() {
    this.successMessageTarget.classList.add("settings-hidden");
    this.errorMessageTarget.classList.add("settings-hidden");
    this.successMessageTarget.textContent = "";
    this.errorMessageTarget.textContent = "";
  }
}
