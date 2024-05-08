import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["sortDirectionField"];

  connect() {
    this.toggleSortDirectionField();
  }

  toggleSortDirectionField() {
    const sortBy = this.element.querySelector("[name='sort_by']:checked").value;
    const sortDirectionSelect = this.sortDirectionFieldTarget.querySelector('select');

    if (sortBy === "date") {
      sortDirectionSelect.innerHTML = `
        <option value="desc">Newest</option>
        <option value="asc">Oldest</option>
      `;
    } else {
      sortDirectionSelect.innerHTML = `
        <option value="desc">Highest</option>
        <option value="asc">Lowest</option>
      `;
    }
  }
}
