import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [
    "password", "passwordCheckItem", "showHide",
    "validations", "field", "error", "passwordContainer"
  ];

  connect() {
    this.validationRegex = [
      /.{8,}/,
      /[A-Z]/,
      /[0-9]/,
      /[^A-Za-z0-9]/
    ];

    this.form = this.element;
    this.fields = this.fieldTargets;
    this.validationStatus = {};

    this.setupEventListeners();
  }

  setupEventListeners() {
    this.passwordTarget.addEventListener("keyup", () => {
      this.validatePassword();
      this.showHideTarget.style.top = '50%';
    });

    this.showHideTarget.addEventListener("click", () => {
      this.togglePasswordVisibility();
    });

    this.passwordTarget.addEventListener("keyup", () => {
      this.toggleValidationsDisplay();
      this.showHideTarget.style.top = '50%';
    });

    this.form.addEventListener("submit", (e) => {
      e.preventDefault();

      this.validateInputs();

      const allInputsValid = Object.values(this.validationStatus).every(
        (status) => status
      );

      if (allInputsValid) {
        this.form.submit();
      }
    });

    this.fieldTargets.forEach((field) => {
      field.addEventListener("input", () => {
        this.clearFieldError(field);
      });
    });
  }

  validatePassword() {
    this.validationRegex.forEach((regex, i) => {
      let isValid = regex.test(this.passwordTarget.value);
      if (isValid) {
        this.passwordCheckItemTargets[i].classList.add("checked");
      } else {
        this.passwordCheckItemTargets[i].classList.remove("checked");
      }
    });
  }

  togglePasswordVisibility() {
    this.passwordTarget.type = this.passwordTarget.type === "password" ? "text" : "password";
    this.showHideTarget.textContent = this.passwordTarget.type === "password" ? "show" : "hide";
  }

  toggleValidationsDisplay() {
    if (this.passwordTarget.value === "") {
      this.validationsTarget.style.opacity = "0";
      this.validationsTarget.style.height = "0";
    } else {
      this.validationsTarget.style.opacity = "1";
      this.validationsTarget.style.height = "112px"; // Fixed height for the validations container
    }
  }

  clearFieldError(field) {
    const errorDisplay = field.querySelector(".error");
    const inputControl = field.firstElementChild;
    const passwordControl = field.firstElementChild.firstElementChild;

    inputControl.classList.remove("success", "failure");
    if (passwordControl !== null) {
      passwordControl.classList.remove("success", "failure");
    }
    errorDisplay.style.display = "none";
  }

  setError(element, message) {
    this.validationStatus[element.id] = false;
    const inputControl = element.parentElement;
    const errorDisplay = inputControl.querySelector(".error");

    errorDisplay.style.display = "block";
    errorDisplay.innerText = message;
    element.classList.add("failure");
    element.classList.remove("success");
  }

  setSuccess(element) {
    this.validationStatus[element.id] = true;
    const inputControl = element.parentElement;
    const errorDisplay = inputControl.querySelector(".error");

    errorDisplay.style.display = "none";
    element.classList.add("success");
    element.classList.remove("failure");
  }

  validateInputs() {
    this.fields.forEach((field) => {
      const input = field.querySelector("input");
      const value = input.value.trim();

      switch (input.id) {
        case "first-name-sign-up-field":
        case "last-name-sign-up-field":
          if (value === "" || value === null) {
            this.setError(input, `${input.placeholder} is required`);
          } else {
            this.setSuccess(input);
          }
          break;
        case "username-sign-up-field":
          if (value === "" || value === null) {
            this.setError(input, "Username is required");
          } else {
            this.checkUsernameAvailability(input, value);
          }
          break;
        case "email-sign-up-field":
          if (value === "" || value === null) {
            this.setError(input, "Email is required");
          } else if (!this.isValidEmail(value)) {
            this.setError(input, "Provide a valid email address");
          } else {
            this.checkEmailAvailability(input, value);
          }
          break;
        case "password-sign-up-field":
          if (value === "") {
            this.setError(input, "Password is required");
            this.showHideTarget.style.top = '35%';
          } else if (
            value.length < 8 ||
            !/[A-Z]/.test(value) ||
            !/\d/.test(value) ||
            !/[/!@#$%^&*(),.?":{}|<>\\]/.test(value)
          ) {
            this.setError(input, "Password is invalid");
            this.showHideTarget.style.top = '35%';
          } else {
            this.setSuccess(input);
            this.showHideTarget.style.top = '50%';
          }
          break;
        default:
          break;
      }
    });
  }

  async checkUsernameAvailability(input, value) {
    try {
      const response = await fetch(`/check_username_availability?username=${value}`);
      const data = await response.json();

      if (data.available) {
        this.setSuccess(input);
      } else {
        this.setError(input, "This username is already taken");
      }
    } catch (error) {
      console.error("Error checking username availability:", error);
    }
  }

  async checkEmailAvailability(input, value) {
    try {
      const response = await fetch(`/check_email_availability?email=${value}`);
      const data = await response.json();

      if (data.available) {
        this.setSuccess(input);
      } else {
        this.setError(input, "This email address is already registered");
      }
    } catch (error) {
      console.error("Error checking email availability:", error);
    }
  }

  isValidEmail(email) {
    const emailRegex = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return emailRegex.test(String(email).toLowerCase());
  }
}
