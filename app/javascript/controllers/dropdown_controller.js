// app/javascript/controllers/dropdown_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["content", "icon"];

  connect() {
    this.closeDropdown();
  }

  toggle(event) {
    if (this.contentTarget.classList.contains("open")) {
      this.closeDropdown();
    } else {
      this.openDropdown();
    }
    event.preventDefault();
  }

  openDropdown() {
    this.contentTarget.classList.add("open");
    this.iconTarget.style.transform = "rotate(90deg)";
  }

  closeDropdown() {
    this.contentTarget.classList.remove("open");
    this.iconTarget.style.transform = "rotate(0deg)";
  }
}
