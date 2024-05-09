import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["sortDirectionField"];

  connect() {
    this.toggleSortDirectionField();
    this.lastClickedRadioButton = null;
    this.lastClickedSortByRadioButton = null;
    this.setupRadioButtons();
  }

  setupRadioButtons() {
    const sortByRadioButtons = this.element.querySelectorAll("[name='sort_by']");
    const sortDirectionRadioButtons = this.element.querySelectorAll("[name='sort_direction']");

    sortByRadioButtons.forEach(sortByRadioButton => {
      sortByRadioButton.addEventListener('click', () => {
        if (sortByRadioButton === this.lastClickedSortByRadioButton) {
          this.lastClickedSortByRadioButton.checked = false;
          this.lastClickedSortByRadioButton = null;
        } else {
          this.lastClickedSortByRadioButton = sortByRadioButton;
        }
      });
    });

    sortDirectionRadioButtons.forEach(sortDirectionRadioButton => {
      sortDirectionRadioButton.addEventListener('click', () => {
        if (sortDirectionRadioButton === this.lastClickedSortDirectionRadioButton) {
          this.lastClickedSortDirectionRadioButton.checked = false;
          this.lastClickedSortDirectionRadioButton = null;
        } else {
          this.lastClickedSortDirectionRadioButton = sortDirectionRadioButton;
        }
      });
    });
  }

  toggleSortDirectionField() {
    const checkedRadioButton = this.element.querySelector("[name='sort_by']:checked");
    if (!checkedRadioButton) return;

    const sortBy = checkedRadioButton.value;
    const sortDirectionLabels = this.sortDirectionFieldTarget.querySelectorAll('label');

    if (sortBy === "date") {
      sortDirectionLabels[0].innerHTML = `
        <input type="radio" name="sort_direction" value="desc" class="filter-form-check-input" ${this.element.querySelector("[name='sort_direction']:checked") == 'desc' ? 'checked' : ''}> Newest
      `;
      sortDirectionLabels[1].innerHTML = `
        <input type="radio" name="sort_direction" value="asc" class="filter-form-check-input" ${this.element.querySelector("[name='sort_direction']:checked") == 'asc' ? 'checked' : ''}> Oldest
      `;
    } else {
      sortDirectionLabels[0].innerHTML = `
        <input type="radio" name="sort_direction" value="desc" class="filter-form-check-input" ${this.element.querySelector("[name='sort_direction']:checked") == 'desc' ? 'checked' : ''}> Highest
      `;
      sortDirectionLabels[1].innerHTML = `
        <input type="radio" name="sort_direction" value="asc" class="filter-form-check-input" ${this.element.querySelector("[name='sort_direction']:checked") == 'asc' ? 'checked' : ''}> Lowest
      `;
    }
  }
}
