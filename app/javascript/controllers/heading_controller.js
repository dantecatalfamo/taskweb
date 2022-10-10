import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ['details', 'state', 'stateSelection', 'options']
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
    this.hideStateSelectorTimeout = window.setTimeout(() => this.hideStateSelector(), 10_000);
  }

  hideStateSelector() {
    this.stateTarget.style.display = '';
    this.stateSelectionTarget.style.display = 'none';
    this.hideStateSelectorTimeout = null;
  }

  stateSelectionSubmit(event) {
    this.stateSelectionTarget.requestSubmit();
  }

  toggleOptions(event) {
    event.preventDefault();
    if (this.optionsTarget.style.display === 'none') {
      this.optionsTarget.style.display = 'inline-block';
    } else {
      this.optionsTarget.style.display = 'none';
    }
  }

  connect() {
    const data = this.getData();
    if (data.open) {
      this.detailsTarget.open = true;
    }
    this.optionsTarget.style.display = 'none';
  }

  disconnect() {
    if (this.hideStateSelectorTimeout) {
      window.clearTimeout(this.hideStateSelectorTimeout);
    }
  }

  toggle(event) {
    const data = this.getData();
    data.open = this.detailsTarget.open;
    this.setData(data);
  }
}
