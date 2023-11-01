import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="view-switcher"
export default class extends Controller {
  static targets = ["card", "magazine", "title"]
  connect() {
    if (this.cardTarget && this.magazineTarget && this.titleTarget){
      if(document.querySelector('.card-view')){
        this.cardTarget.parentElement.classList.add('active');
      } else if(document.querySelector('.magazine-view')) {
        this.magazineTarget.parentElement.classList.add('active');
      } else if(document.querySelector('.title-view')) {
        this.titleTarget.parentElement.classList.add('active');
      }
    }
  }

  switchView(event) {
    const results = document.getElementById('results-container');
    const view = event.target.dataset.view;
    results.classList.remove("title-view", "magazine-view", "card-view");
    results.classList.add(view);
  }
}
