import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal", "input"]

  clearInput() {
    document.getElementById("category_title").value = '';
  }
}