import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  remove(event) {
    event.target.parentNode.remove()
  }
}
