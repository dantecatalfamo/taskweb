import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
  }

  processInput(event) {
    if (event.keyCode === 13) {
      // If the previous line begins with a bullet point or
      // indentation, add it to the beginning of this line
      const pos = this.element.selectionStart;
      const newlines = this.newlinePositions();
      const prevLineBegin = newlines.reduce((acc, n) => (n < pos-1 ? n : acc));
      const prevLine = this.element.value.substring(prevLineBegin+1, pos).replace('\n', '');
      // Find the non-word component and uncheck any checkboxes
      const lead = prevLine.match(/^\W*(x\] )?/)[0].replace('[x]', '[ ]');
      // Don't copy things like '#+' from #+NAME to new lines
      if (!lead.trim().startsWith('#')) {
        this.element.setRangeText(lead);
        this.element.selectionStart += lead.length;
      }
    }
  }

  newlinePositions() {
    const len = this.element.value.length;
    const positions = [];
    for (let i = 0; i < len; i++) {
      if (this.element.value[i] === '\n') {
        positions.push(i);
      }
    }
    return positions;
  }
}
