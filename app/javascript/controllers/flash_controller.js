import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="flash"
export default class extends Controller {
  static targets = ['close']

  connect() {
    this.removeTimeout = window.setTimeout(() => this.element.remove(), 10_000);
  }

  disconnect() {
    if (this.removeTimeout) {
      window.clearTimeout(this.removeTimeout);
    }
  }

  remove(event) {
    event.preventDefault();
    this.element.remove();
  }
}
