import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ['agenda', 'headings'];

  connect() {
    this.headingsTarget.addEventListener("turbo:submit-end", this.reloadAgenda);
    this.agendaRefresh = setInterval(this.reloadAgenda, 5 * 60 * 1000);
    const notebooks = this.headingsTarget.querySelector("#notebooks");
    notebooks.dataset.turboAction = 'advance';
    window.notebooks = notebooks;
  }

  disconnect() {
    clearInterval(this.agendaRefresh);
  }

  reloadAgenda = () => {
    const agenda = this.agendaTarget.querySelector('#agenda');
    agenda.src = '/agenda';
    agenda.reload();
  }
}
