import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ['agenda', 'headings'];

  connect() {
    this.headingsTarget.addEventListener("turbo:submit-end", this.reloadAgenda);
    const agendaFrame = this.agendaTarget.querySelector("#agenda");
    this.agendaRefresh = setInterval(() => agendaFrame.reload(), 5 * 60 * 1000);
  }

  disconnect() {
    clearInterval(this.agendaRefresh);
  }

  reloadAgenda = () => {
    const agenda = this.agendaTarget.querySelector('#agenda');
    agenda.reload();
  }
}
