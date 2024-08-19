// app/javascript/controllers/animation_controller.js
import { Controller } from "@hotwired/stimulus"
console.log("i")

// Connects to data-controller="animation"
export default class extends Controller {
  static targets = ["rotate"]

  connect() {
    this.initializeTxtRotate();
  }

  initializeTxtRotate() {
    this.rotateTargets.forEach((element) => {
      const toRotate = JSON.parse(element.dataset.rotate);
      const period = element.dataset.period;
      new TxtRotate(element, toRotate, period);
    });
  }
}

class TxtRotate {
  constructor(el, toRotate, period) {
    this.toRotate = toRotate;
    this.el = el;
    this.loopNum = 0;
    this.period = parseInt(period, 10) || 2000;
    this.txt = '';
    this.tick();
    this.isDeleting = false;
  }

  tick() {
    let i = this.loopNum % this.toRotate.length;
    let fullTxt = this.toRotate[i];

    if (this.isDeleting) {
      this.txt = fullTxt.substring(0, this.txt.length - 1);
    } else {
      this.txt = fullTxt.substring(0, this.txt.length + 1);
    }

    this.el.innerHTML = '<span class="wrap">' + this.txt + '</span>';

    let delta = 300 - Math.random() * 100;
    if (this.isDeleting) { delta /= 2; }

    if (!this.isDeleting && this.txt === fullTxt) {
      delta = this.period;
      this.isDeleting = true;
    } else if (this.isDeleting && this.txt === '') {
      this.isDeleting = false;
      this.loopNum++;
      delta = 500;
    }

    setTimeout(() => this.tick(), delta);
  }
}