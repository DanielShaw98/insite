import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["form", "followMessage"];
  static values = { follow: Boolean };

  formOrMessage(event) {
    if (this.followValue) {
      this.showPledgeForm();
    } else {
      this.followMessageTarget.style.display = 'block';
    }
  }

  showPledgeForm() {
    const form = this.formTarget;
    if (form.classList.contains('pledge-form-show')) {
        form.classList.remove('pledge-form-show');
        form.classList.add('pledge-form-hide');
    } else {
        form.style.display = 'block';
        form.classList.remove('pledge-form-hide');
        form.classList.add('pledge-form-show');
    }
  }
}
