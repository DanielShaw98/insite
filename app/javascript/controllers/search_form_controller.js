import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['input', 'dropdown'];

  connect() {
    // Add event listener for input blur
    this.inputTarget.addEventListener('blur', (event) => {
      // Check if the related target (where focus went) is not within the dropdown
      if (!this.dropdownTarget.contains(event.relatedTarget)) {
        // Clear the dropdown only if focus is moved outside of the dropdown
        this.clearDropdown();
      }
    });
  }


  input(event) {
    const query = event.target.value.trim(); // Trim whitespace

    // Check if query is not empty
    if (query.length > 0) {
      // Make an AJAX request to fetch search suggestions
      fetch(`/search?query=${query}`)
        .then(response => response.json())
        .then(data => {
          // Process the data and populate the dropdown with search suggestions
          this.populateDropdown(data.suggestions);
        })
        .catch(error => {
          console.error('Error fetching search suggestions:', error);
        });
    } else {
      // If query is empty, clear the dropdown and remove active class
      this.clearDropdown();
    }
  }

  clearDropdown() {
    const dropdown = this.dropdownTarget;
    dropdown.innerHTML = ''; // Clear dropdown
  }

  populateDropdown(suggestions) {
    const dropdown = this.dropdownTarget;

    // Clear existing dropdown options
    dropdown.innerHTML = '';

    // Check if suggestions is not null or undefined
    if (suggestions) {
      // Add new options based on search suggestions
      suggestions.forEach(suggestion => {
        // Create a new anchor element
        const link = document.createElement('a');

        // Set the href attribute to the suggestion.url
        link.href = suggestion.url;

        // Create a new image element
        const image = document.createElement('img');

        // Set the src attribute to the suggestion.image
        image.src = suggestion.image;
        image.alt = 'Thumbnail'; // Optionally set alt text

        // Set the class based on the suggestion type
        if (suggestion.type === 'video') {
          image.classList.add('search-video-thumbnail');
        } else {
          image.classList.add('search-creator-avatar');
        }

        // Set the text content of the link
        link.textContent = suggestion.text;

        // Create a new list item element
        const listItem = document.createElement('li');

        // Append the image to the list item
        listItem.appendChild(image);

        // Append the link to the list item
        listItem.appendChild(link);

        // Append the list item to the dropdown
        dropdown.appendChild(listItem);
      });
    }
  }
}
