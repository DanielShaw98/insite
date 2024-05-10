import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["sortDirectionField"];

  connect() {
    this.toggleSortDirectionField();
  }

  toggleSortDirectionField() {
    const sortBySelect = this.element.querySelector("[name='sort_by']");
    const sortDirectionSelect = this.sortDirectionFieldTarget.querySelector('select');

    sortBySelect.addEventListener('change', () => {
      const sortBy = sortBySelect.value;

      // Clear existing options
      sortDirectionSelect.innerHTML = '';

      if (sortBy === "date") {
        // Add options for date sorting
        sortDirectionSelect.innerHTML += `
          <option value="desc">Newest</option>
          <option value="asc">Oldest</option>
        `;
      } else {
        // Add options for other sorting types
        sortDirectionSelect.innerHTML += `
          <option value="desc">Highest</option>
          <option value="asc">Lowest</option>
        `;
      }
    });

    // Trigger the change event initially to set initial options
    sortBySelect.dispatchEvent(new Event('change'));
  }
}
