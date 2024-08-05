import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "waiting", "status", "response", "link" ]
  static values = { diaryId: Number }

  connect() {
    this.dots = 0
    this.totalTime = 0
    this.animateDots()
    this.checkResponse()
  }

  animateDots() {
    this.dotsInterval = setInterval(() => {
      this.dots = (this.dots + 1) % 6
      this.statusTarget.textContent = '現在アルディアスが返答を記載中' + '.'.repeat(this.dots)
      this.totalTime++
    }, 1000)
  }

  checkResponse() {
    fetch(`/diaries/${this.diaryIdValue}/check_response`, {
      headers: {
        "Accept": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
      },
    })
      .then(response => response.json())
      .then(data => {
        if (data.response) {
          clearInterval(this.dotsInterval)
          this.hideWaiting()
          setTimeout(() => this.showResponse(data.response), 1000)
        } else {
          setTimeout(() => this.checkResponse(), 5000) // 5秒ごとにチェック
        }
      })
  }

  hideWaiting() {
    this.waitingTarget.classList.add('animate-fade-out-down')
    setTimeout(() => {
      this.waitingTarget.style.display = 'none'
      this.responseTarget.style.display = 'block'
    }, 1000)
  }

  showResponse(response) {
    let i = 0
    const intervalId = setInterval(() => {
      if (i < response.length) {
        this.responseTarget.textContent += response[i]
        i++
      } else {
        clearInterval(intervalId)
        this.showLink()
      }
    }, 100) // 100ミリ秒ごとに1文字追加
  }

  showLink() {
    this.linkTarget.style.display = 'block'
    this.linkTarget.classList.add('animate-fade-in')
  }
}