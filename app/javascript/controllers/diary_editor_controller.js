import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["content", "contentLabel", "editForm", "cancelButton", "editLink", "image", "imagePreview", "response"]

  connect() {
    this.originalContent = this.contentTarget.innerHTML
    this.originalImage = this.hasImageTarget ? this.imageTarget.src : null
    this.loadEditMode()
  }

  startEdit() {
    this.enterEditMode()
    this.saveEditMode(true)
  }

  cancelEdit() {
    this.exitEditMode()
    this.saveEditMode(false)
    if (this.hasImagePreviewTarget) {
      this.imagePreviewTarget.src = this.originalImage
    }
  }

  enterEditMode() {
    this.contentTarget.classList.add("hidden")
    this.contentLabelTarget.classList.add("hidden")
    this.editFormTarget.classList.remove("hidden")
    this.cancelButtonTarget.classList.remove("hidden")
    this.editLinkTarget.classList.add("hidden")
    this.responseTarget.classList.add("hidden")
    if (this.hasImageTarget) {
      this.imageTarget.classList.add("hidden")
    }
    if (this.hasImagePreviewTarget) {
      this.imagePreviewTarget.classList.remove("hidden")
    }
  }

  exitEditMode() {
    this.contentTarget.classList.remove("hidden")
    this.contentLabelTarget.classList.remove("hidden")
    this.editFormTarget.classList.add("hidden")
    this.cancelButtonTarget.classList.add("hidden")
    this.editLinkTarget.classList.remove("hidden")
    this.responseTarget.classList.remove("hidden")
    if (this.hasImageTarget) {
      this.imageTarget.classList.remove("hidden")
    }
    if (this.hasImagePreviewTarget) {
      this.imagePreviewTarget.classList.add("hidden")
    }
  }

  saveEditMode(isEditing) {
    localStorage.setItem(`diary-${this.element.dataset.diaryId}-editing`, isEditing)
  }

  loadEditMode() {
    const isEditing = localStorage.getItem(`diary-${this.element.dataset.diaryId}-editing`) === 'true'
    if (isEditing) {
      this.enterEditMode()
    } else {
      this.exitEditMode()
    }
  }

  submitForm(event) {
    event.preventDefault()
    const form = event.target
    const formData = new FormData(form)

    fetch(form.action, {
      method: form.method,
      body: formData,
      headers: {
        'Accept': 'application/json'
      }
    })
    .then(response => response.json())
    .then(data => {
      if (data.success) {
        this.contentTarget.innerHTML = data.content
        if (data.image_url && this.hasImageTarget) {
          this.imageTarget.src = data.image_url
          this.imageTarget.classList.remove('hidden')
        } else if (this.hasImageTarget) {
          this.imageTarget.classList.add('hidden')
        }
        
        // Flashメッセージを表示
        this.showFlash(data.flash.notice, 'notice')
      } else {
        // エラーメッセージを表示
        this.showFlash(data.flash.alert, 'alert')
      }
    })
    .catch(error => {
      console.error('Error:', error)
      this.showFlash('エラーが発生しました。', 'alert')
    })
  }

  showFlash(message, type) {
    const flashContainer = document.createElement('div')
    flashContainer.innerHTML = `
      <div class="animate-flash fixed top-24 translate-x-1/2 right-6 sm:translate-x-0 z-30 w-fit max-w-[90%] sm:max-w-1/2 py-4 px-6 flex justify-center items-center bg-white shadow-lg border border-line-100 rounded-[3px] flash-message" data-controller="flash">
        <p class="text-base font-bold ${type === 'alert' ? 'text-secondary-200' : 'text-dark-blue-200'} !leading-none">${message}</p>
      </div>
    `
    const flashElement = flashContainer.firstElementChild
    document.body.appendChild(flashElement)

    setTimeout(() => {
      if (flashElement && flashElement.parentNode) {
        flashElement.parentNode.removeChild(flashElement)
      }
    }, 3000)
  }

  previewImage(event) {
    const input = event.target
    const preview = this.imagePreviewTarget

    if (input.files && input.files[0]) {
      const reader = new FileReader()

      reader.onload = (e) => {
        preview.src = e.target.result
        preview.classList.remove("hidden")
      }

      reader.readAsDataURL(input.files[0])
    }
  }

  removeImage() {
    if (this.hasImageTarget) {
      this.imageTarget.classList.add("hidden")
    }
    if (this.hasImagePreviewTarget) {
      this.imagePreviewTarget.classList.add("hidden")
    }
    document.getElementById("remove_image").checked = "1"
  }
}