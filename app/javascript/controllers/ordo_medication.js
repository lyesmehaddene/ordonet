import { Controller } from "@hotwired/stimulus"


export default class extends Controller {
  static targets = ['closebtn', 'modalElement']

  close(e) {
    // Prevent default action
    e.preventDefault();
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
