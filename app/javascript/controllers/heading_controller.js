import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ['details']
  static values = { id: Number }

  getData() {
    return JSON.parse(localStorage.getItem(`heading_${this.idValue}`)) || {};
  }

  setData(data) {
    localStorage.setItem(`heading_${this.idValue}`, JSON.stringify(data));
  }

  connect() {
    const data = this.getData();
    if (data.open) {
      this.detailsTarget.open = true;
    }
  }

  toggle(event) {
    const data = this.getData();
    data.open = this.detailsTarget.open;
    this.setData(data);
  }
}
