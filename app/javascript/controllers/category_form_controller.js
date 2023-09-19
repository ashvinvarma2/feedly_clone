import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal", "input"]

  handleSuccess() {
    this.inputTarget.querySelector('input').value = '';
  }

  handleError(event) {
    console.log("Error handled!!!");
    const [data, status, xhr] = event.detail
    console.error(data.errors) // You can handle the error here
  }
}