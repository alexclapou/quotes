import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="filters"
export default class extends Controller {
  static targets = ['search']
  timeout = null

  delayedSearch() {
    clearTimeout(this.timeout)

    this.timeout = setTimeout(() => {
      this.#search()
    }, 350)
  }

  #search() {
    const query = this.searchTarget.value
    const quotesFrame = document.getElementById('quotes')
    let src = `?query=${query}`
    quotesFrame.src = src
  }
}
