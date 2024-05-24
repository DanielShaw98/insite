import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["field", "error", "password", "showHide"];
  emailIsValid = false;
  passwordIsValid = false;

  connect() {
    this.fieldTargets.forEach((field) => {
      field.addEventListener("input", () => {
        this.clearFieldError(field);
      });
    });

    this.element.addEventListener("submit", (event) => {
      event.preventDefault();
      this.validateInputs();
    });

    this.showHideTarget.addEventListener("click", () => {
      this.togglePasswordVisibility();
    });
  }

  togglePasswordVisibility() {
    this.passwordTarget.type = this.passwordTarget.type === "password" ? "text" : "password";
    this.showHideTarget.textContent = this.passwordTarget.type === "password" ? "show" : "hide";
  }

  setError(element, message) {
    const inputControl = element.parentElement;
    const errorDisplay = inputControl.querySelector(".login-error");

    errorDisplay.style.display = "block";
    errorDisplay.innerText = message;
    element.classList.add("login-failure");
    element.classList.remove("login-success");

    if (element.id === "user-password") {
      this.showHideTarget.style.top = '35%';
    }
  }

  setSuccess(element) {
    const inputControl = element.parentElement;
    const errorDisplay = inputControl.querySelector(".login-error");

    errorDisplay.style.display = "none";
    element.classList.add("login-success");
    element.classList.remove("login-failure");

    if (element.id === "user-password") {
      this.showHideTarget.style.top = '50%';
    }
  }

  clearFieldError(field) {
    const errorDisplay = field.querySelector(".login-error");
    const inputControl = field.firstElementChild;
    const passwordControl = field.firstElementChild.firstElementChild;

    inputControl.classList.remove("login-success", "login-failure");
    if (passwordControl !== null) {
      passwordControl.classList.remove("login-success", "login-failure");
    }
    errorDisplay.style.display = "none";

    if (passwordControl && passwordControl.id === "user-password") {
      this.showHideTarget.style.top = '50%';
    }
  }

  validateInputs() {
    let emailInput, passwordInput;
    let emailValue, passwordValue;

    this.fieldTargets.forEach((field) => {
      const input = field.querySelector("input");
      switch (input.id) {
        case "user-email":
          emailInput = input;
          emailValue = input.value.trim();
          break;
        case "user-password":
          passwordInput = input;
          passwordValue = input.value.trim();
          break;
        default:
          break;
      }
    });

    if (emailValue === "" && passwordValue !== "") {
      this.setError(passwordInput, "Email is required");
      return;
    }

    if (emailValue === "") {
      this.setError(emailInput, "Email is required");
      return;
    } else {
      this.checkEmailExists(emailInput, emailValue);
    }
  }

  async checkEmailExists(input, value) {
    try {
      const response = await fetch(`/check_email_exists?email=${value}`);
      const data = await response.json();

      if (data.exists) {
        this.setSuccess(input);
        this.emailIsValid = true;
        this.validatePassword();
      } else {
        this.setError(input, "This email is not registered");
      }
    } catch (error) {
      console.error("Error checking email exists:", error);
    }
  }

  async validatePassword() {
    const passwordInput = this.element.querySelector("#user-password");
    const passwordValue = passwordInput.value.trim();

    if (passwordValue === "") {
      this.setError(passwordInput, "Password is required");
      return;
    }

    try {
      const emailValue = this.element.querySelector("#user-email").value.trim();
      const response = await fetch(`/check_password_correct?email=${emailValue}&password=${passwordValue}`);
      const data = await response.json();

      if (data.correct) {
        this.setSuccess(passwordInput);
        this.passwordIsValid = true;
        if (this.emailIsValid && this.passwordIsValid) {
          this.element.submit();
        }
      } else {
        this.setError(passwordInput, "Password incorrect");
      }
    } catch (error) {
      console.error("Error checking password correctness:", error);
    }
  }
}
