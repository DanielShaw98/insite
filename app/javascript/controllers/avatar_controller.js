import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["dropdown", "avatarImage"];

  connect() {
    document.body.addEventListener('click', this.hideDropdown.bind(this));
  }

  click(event) {
    this.toggleDropdown();
  }

  toggleDropdown() {
    const dropdown = this.dropdownTarget;
    const avatarImage = this.avatarImageTarget;

    dropdown.style.display = dropdown.style.display === 'block' ? 'none' : 'block';
    avatarImage.style.border = dropdown.style.display === 'block' ? '2px solid #00A693' : '2px solid #FFF';
  }

  hideDropdown(event) {
    const dropdown = this.dropdownTarget;
    const avatarImage = this.avatarImageTarget;

    if (!dropdown.contains(event.target) && !avatarImage.contains(event.target)) {
      dropdown.style.display = 'none';
      avatarImage.style.border = '2px solid #FFF';
    }
  }
}
