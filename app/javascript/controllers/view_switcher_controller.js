import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="view-switcher"
export default class extends Controller {
  static targets = ["card", "magazine"]

  connect() {
    if(document.querySelector('.card-view')){
      this.cardTarget.parentElement.classList.add('active');
    } else {
      this.magazineTarget.parentElement.classList.add('active');
    }
  }

  switchView(event) {
    const results = document.getElementById('results-container');
    const view = event.target.dataset.view;
    results.classList.remove("title-view", "magazine-view", "card-view");
    results.classList.add(view);
  }
}
