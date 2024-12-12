import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['input', 'dropdown'];

  connect() {
    this.inputTarget.addEventListener('blur', (event) => {
      if (!this.dropdownTarget.contains(event.relatedTarget)) {
        this.clearDropdown();
      }
    });
  }


  input(event) {
    const query = event.target.value.trim();

    if (query.length > 0) {
      fetch(`/search?query=${query}`)
        .then(response => response.json())
        .then(data => {
          this.populateDropdown(data.suggestions);
        })
        .catch(error => {
          console.error('Error fetching search suggestions:', error);
        });
    } else {
      this.clearDropdown();
    }
  }

  clearDropdown() {
    const dropdown = this.dropdownTarget;
    dropdown.innerHTML = '';
  }

  populateDropdown(suggestions) {
    const dropdown = this.dropdownTarget;

    dropdown.innerHTML = '';

    if (suggestions) {
      suggestions.forEach(suggestion => {
        const link = document.createElement('a');

        link.href = suggestion.url;

        const image = document.createElement('img');

        image.src = suggestion.image;
        image.alt = 'Thumbnail';

        if (suggestion.type === 'video') {
          image.classList.add('search-video-thumbnail');
        } else {
          image.classList.add('search-creator-avatar');
        }

        link.textContent = suggestion.text;

        const listItem = document.createElement('li');

        listItem.appendChild(image);

        listItem.appendChild(link);

        dropdown.appendChild(listItem);
      });
    }
  }
}
