import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [ "modal" ];

  connect() {
    console.log("ok");
  }

  toggleModal(event) {
    if (this.modalTarget.classList.contains("hidden")) {
      this.modalTarget.classList.remove("hidden");
      event.currentTarget.textContent = '詳細を閉じる';
    } else {
      this.modalTarget.classList.add("hidden");
      event.currentTarget.textContent = 'さらに絞り込む';
    }
  }
}
