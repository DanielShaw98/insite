import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["form"];

  showPledgeForm(event) {
    const form = this.formTarget;
    if (form.classList.contains('pledge-form-show')) {
        form.classList.remove('pledge-form-show');
        form.classList.add('pledge-form-hide');
    } else {
        form.style.display = 'block'; // Ensure the form is visible before adding the show class
        form.classList.remove('pledge-form-hide');
        form.classList.add('pledge-form-show');
    }
  }
}
