import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="error-handler"
export default class extends Controller {
  static targets = ['link', 'errorMessage'];

  validate(event) {
    if (this.linkTarget.value.trim() === '') {
      event.preventDefault();
      this.linkTarget.style.borderColor = "red";
      this.errorMessageTarget.style.display = "block";
    }
  }

  submit(event) {
    this.validate(event);
  }
}
