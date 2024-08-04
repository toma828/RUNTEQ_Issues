import { Controller } from "@hotwired/stimulus"
console.log("V")

export default class extends Controller {
  static targets = ["preview"]

  preview(event) {
    const input = event.target
    const preview = this.previewTarget

    if (input.files && input.files[0]) {
      const reader = new FileReader()

      reader.onload = (e) => {
        preview.querySelector('img').src = e.target.result
        preview.classList.remove('hidden')
      }

      reader.readAsDataURL(input.files[0])
    } else {
      preview.classList.add('hidden')
      preview.querySelector('img').src = ''
    }
  }
}