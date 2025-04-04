import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash"
export default class extends Controller {
  static targets = ['container']

  connect() {
    setTimeout(() => {
      this.containerTarget.style.display = 'none';
    }, 2000);
  }
}
