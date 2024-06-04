import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["usernameField", "currentPasswordField", "newPasswordField", "passwordConfirmationField",
   "usernameSuccessMessage", "usernameErrorMessage", "passwordSuccessMessage", "passwordErrorMessage", "avatarSuccessMessage", "avatarErrorMessage"];

  connect() {
    this.clearMessages();
  }

  validateUsername(event) {
    event.preventDefault();

    const usernameValue = this.usernameFieldTarget.value.trim();
    const currentUsername = this.usernameFieldTarget.dataset.currentUsername.trim();

    if (usernameValue === "") {
      this.displayErrorMessage("username", "Username cannot be blank.");
      return;
    }

    if (usernameValue === currentUsername) {
      this.displayErrorMessage("username", "New username cannot be the same as the current username.");
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
        this.displayErrorMessage("username", "This username is already taken.");
      } else {
        // Submit the form data via AJAX to actually update the username
        this.submitUsernameForm(form);
      }
    }).catch(error => {
      console.error("Error checking username:", error);
      this.displayErrorMessage("username", "Error checking username availability.");
    });
  }

  submitUsernameForm(form) {
    const formData = new FormData(form);
    const jsonBody = {
      user: {
        username: formData.get('user[username]')
      }
    };

    fetch(form.action, {
      method: 'PATCH',
      headers: {
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
      body: JSON.stringify(jsonBody),
      credentials: 'same-origin'
    })
    .then(response => {
      if (!response.ok) {
        throw new Error('Network response was not ok ' + response.statusText);
      }
      return response.json();
    })
    .then(data => {
      if (data.status === 'error') {
        this.displayErrorMessage("username", data.message);
      } else {
        this.displaySuccessMessage("username", data.message);
      }
    })
    .catch(error => {
      console.error("Error submitting form:", error);
      this.displayErrorMessage("username", "An error occurred while updating the username.");
    });
  }

  validatePassword(event) {
    event.preventDefault();
    const form = event.target;
    const currentPassword = this.currentPasswordFieldTarget.value;
    const newPassword = this.newPasswordFieldTarget.value;
    const passwordConfirmation = this.passwordConfirmationFieldTarget.value;
    let messages = [];

    if (newPassword === currentPassword) {
        messages.push("New password must be different from the current password.");
    }

    if (newPassword !== passwordConfirmation) {
        messages.push("New password and confirmation password do not match.");
    }

    if (messages.length === 0) {
        if (newPassword.length < 8) {
            messages.push("Password must be at least 8 characters long.");
        }
        if (!/[A-Z]/.test(newPassword)) {
            messages.push("Password must include at least one uppercase letter.");
        }
        if (!/\d/.test(newPassword)) {
            messages.push("Password must include at least one number.");
        }
        if (!/[^A-Za-z0-9]/.test(newPassword)) {
            messages.push("Password must include at least one special character.");
        }
    }

    if (messages.length > 0) {
        this.displayErrorMessage("password", messages.join("<br>"));
    } else {
        this.displaySuccessMessage("password", "Password successfully changed.");
        this.submitPasswordForm(form);
    }
  }

  submitPasswordForm(form) {
    const formData = new FormData(form);
    const jsonBody = {
        user: {
            current_password: formData.get('user[current_password]'),
            password: formData.get('user[password]'),
            password_confirmation: formData.get('user[password_confirmation]')
        }
    };

    fetch(form.action, {
        method: 'PATCH',
        headers: {
            'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
            'Content-Type': 'application/json',
            'Accept': 'application/json'
        },
        body: JSON.stringify(jsonBody),
        credentials: 'same-origin'
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Network response was not ok ' + response.statusText);
        }
        return response.json();
    })
    .then(data => {
        if (data.status === 'error') {
            this.displayErrorMessage("password", data.message);
        } else {
            this.displaySuccessMessage("password", data.message);
        }
    })
    .catch(error => {
        console.error("Error submitting form:", error);
        this.displayErrorMessage("password", "An error occurred while updating the password.");
    });
  }

  clearFieldError(event) {
    const fieldIdentifier = event.currentTarget.dataset.settingsFormTarget;
    const formPart = this.determineFormPart(fieldIdentifier);
    this.clearSpecificMessages(formPart);
  }

  clearMessages() {
    ['Username', 'Password', 'Avatar'].forEach(part => {
      this.clearSpecificMessages(part);
    });
  }

  determineFormPart(fieldIdentifier) {
    const partMapping = {
        currentPasswordField: 'password',
        newPasswordField: 'password',
        passwordConfirmationField: 'password',
        usernameField: 'username',
        avatarField: 'avatar'
    };
    return partMapping[fieldIdentifier]
  }

  clearSpecificMessages(formPart) {
    const errorTarget = `${formPart}ErrorMessage`;
    const successTarget = `${formPart}SuccessMessage`;

    if (this.targets.has(errorTarget)) {
      this.targets.find(errorTarget).textContent = '';
      this.targets.find(errorTarget).classList.add('settings-hidden');
    }
    if (this.targets.has(successTarget)) {
      this.targets.find(successTarget).textContent = '';
      this.targets.find(successTarget).classList.add('settings-hidden');
    }
  }

  displayErrorMessage(formPart, message) {
    const errorMessageTarget = this.targets.find(`${formPart}ErrorMessage`);
    errorMessageTarget.innerHTML = message;
    errorMessageTarget.classList.remove("settings-hidden");

    const successMessageTarget = this.targets.find(`${formPart}SuccessMessage`);
    successMessageTarget.classList.add("settings-hidden");
  }

  displaySuccessMessage(formPart, message) {
    const successMessageTarget = this.targets.find(`${formPart}SuccessMessage`);
    successMessageTarget.textContent = message;
    successMessageTarget.classList.remove("settings-hidden");

    const errorMessageTarget = this.targets.find(`${formPart}ErrorMessage`);
    errorMessageTarget.classList.add("settings-hidden");
  }
}
