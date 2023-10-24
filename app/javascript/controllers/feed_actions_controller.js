import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="feed-actions"
export default class extends Controller {
  connect() {
    console.log("Feed Action controller is activated!!")
  }

  handleFavorite(event){
    if (event.currentTarget.classList.contains('fa-regular')) {
      event.currentTarget.classList.remove('fa-regular');
      event.currentTarget.classList.add('fa-solid');
      event.currentTarget.setAttribute('data-bs-original-title', 'Remove from Favorites');
      event.currentTarget.setAttribute('aria-label', 'Remove from Favorites');
    } else {
      event.currentTarget.classList.add('fa-regular');
      event.currentTarget.classList.remove('fa-solid');
      event.currentTarget.setAttribute('data-bs-original-title', 'Mark favorite');
      event.currentTarget.setAttribute('aria-label', 'Mark favorite');
    }
  }
}
