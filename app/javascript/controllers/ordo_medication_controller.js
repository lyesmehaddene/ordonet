import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="ordo-medication"
export default class extends Controller {
  connect() {
  }

  static targets = ['closebtn', 'modalElement']

  close(e) {
    // Prevent default action
    e.preventDefault();
    console.log("close");
    // Remove from parent
    const modal = document.getElementById("my_modal");
    modal.innerHTML = "";

    // Remove the src attribute from the modal
    modal.removeAttribute("src");

    // Remove complete attribute
    modal.removeAttribute("complete");

    //Hide element
    modal.classList.add('d-none');
  }
}
