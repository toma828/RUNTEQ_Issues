import { Controller } from "@hotwired/stimulus"
import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';

export default class extends Controller {
  static targets = [ "input", "calendar" ]

  connect() {
    this.calendar = new Calendar(this.calendarTarget, {
      plugins: [ dayGridPlugin ],
      initialView: 'dayGridMonth',
      selectable: true,
      select: this.dateSelected.bind(this)
    });
    this.calendar.render();
  }

  disconnect() {
    if (this.calendar) {
      this.calendar.destroy();
    }
  }

  toggle() {
    console.log('Toggle method called');
    this.calendarTarget.classList.toggle('hidden');
  }

  dateSelected(info) {
    const selectedDate = info.startStr;
    this.inputTarget.value = selectedDate;
    window.location.href = `/diaries?start_date=${selectedDate}`;
  }
}