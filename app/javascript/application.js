// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "flatpickr/dist/flatpickr.min.css"
import { gsap } from "gsap"

// GSAPをグローバルに利用可能にする
window.gsap = gsap;
