import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal", "input"]

  handleSuccess() {
    this.inputTarget.querySelector('input').value = '';
  }
}