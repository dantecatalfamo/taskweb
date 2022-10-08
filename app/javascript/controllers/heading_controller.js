import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ['details', 'state', 'stateSelection']
  static values = { id: Number }

  getData() {
    return JSON.parse(localStorage.getItem(`heading_${this.idValue}`)) || {};
  }

  setData(data) {
    localStorage.setItem(`heading_${this.idValue}`, JSON.stringify(data));
  }

  showStateSelector(event) {
    event.preventDefault();
    this.stateTarget.style.display = 'none';
    this.stateSelectionTarget.style.display = 'inline';
  }

  stateSelectionSubmit(event) {
    this.stateSelectionTarget.requestSubmit();
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
