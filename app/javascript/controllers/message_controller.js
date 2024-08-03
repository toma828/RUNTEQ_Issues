import { Controller } from "@hotwired/stimulus";
console.log("s")

export default class extends Controller {
    static targets = ["message"];

    show() {
        this.messageTarget.style.display = "block"; // メッセージを表示
    }
}
