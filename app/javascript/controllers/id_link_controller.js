import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["icon"];
  static values = {
    id: String,
    title: String,
  }

  chainIcon = 'bi-link-45deg';
  checkIcon = 'bi-check';

  connect() {
  }

  copy(event) {
    event.preventDefault();
    this.check();
    window.setTimeout(() => this.uncheck(), 2000);
    navigator.clipboard.writeText(`[[id:${this.idValue}][${this.titleValue}]]`);
  }

  check() {
    this.iconTarget.classList.remove(this.chainIcon);
    this.iconTarget.classList.add(this.checkIcon);
  }

  uncheck() {
    this.iconTarget.classList.remove(this.checkIcon);
    this.iconTarget.classList.add(this.chainIcon);
  }
}
