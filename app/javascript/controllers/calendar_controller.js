import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["year", "month", "day"]

  connect() {
    this.updateDays()
  }

  updateDays() {
    const year = parseInt(this.yearTarget.value)
    const month = parseInt(this.monthTarget.value)
    const currentDay = parseInt(this.dayTarget.value)
    const daysInMonth = new Date(year, month, 0).getDate()

    this.dayTarget.innerHTML = ''
    for (let i = 1; i <= daysInMonth; i++) {
      const option = document.createElement('option')
      option.value = i
      option.textContent = i
      this.dayTarget.appendChild(option)
    }

    if (currentDay <= daysInMonth) {
      this.dayTarget.value = currentDay
    }
  }

  goToSelectedWeek(event) {
    event.preventDefault()
    const year = this.yearTarget.value
    const month = this.monthTarget.value.padStart(2, '0')
    const day = this.dayTarget.value.padStart(2, '0')
    const selectedDate = `${year}-${month}-${day}`
    window.location.href = `/diaries?selected_date=${selectedDate}`
  }
}