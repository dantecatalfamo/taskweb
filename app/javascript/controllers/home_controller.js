import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ['agenda', 'headings'];

  connect() {
    this.headingsTarget.addEventListener("turbo:frame-load", this.reloadAgenda);
  }

  reloadAgenda = () => {
    const agenda = this.agendaTarget.querySelector('#agenda');
    agenda.reload();
  }
}
