import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="filters"
export default class extends Controller {
  static targets = ['searchForm']

  connect() {
    const input = this.searchFormTarget.querySelector("input[type='text']");

    if (input && input.value.trim() !== "") {
      input.setSelectionRange(input.value.length, input.value.length);
    }
  }

  timeout = null

  delayedSearch() {
    clearTimeout(this.timeout)

    this.timeout = setTimeout(() => {
      this.#search()
    }, 350)
  }

  // https://discuss.hotwired.dev/t/triggering-turbo-frame-with-js/1622/15
  #search() {
    this.searchFormTarget.requestSubmit()
  }
}
