import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="quotes"
export default class extends Controller {
  clearForm() {
    const newFrame = document.getElementById('new_quote')

    newFrame.innerHTML = ''
  }
}
