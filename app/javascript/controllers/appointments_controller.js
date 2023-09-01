import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="appointments"
export default class extends Controller {
  static targets = ['closebtn', 'modalElement']

  connect() {
    console.log("Hello from StimulusJS")
    const myConsultsBtn = document.getElementById('my-consults-btn');
    const allConsultsBtn = document.getElementById('all-consults-btn');
    const myConsults = document.getElementById('my-consults');
    const allConsults = document.getElementById('all-consults');
    // const editButtons = document.querySelectorAll('[id^="editButton_"]');

    // Make 'Mes consultations' active and 'Toutes les consultations' non-active when the page loads
    myConsultsBtn.classList.add("active");
    myConsultsBtn.classList.remove("non-active");
    allConsultsBtn.classList.add("non-active");
    allConsultsBtn.classList.remove("active");

    // Initial display settings
    myConsults.style.display = "block";
    allConsults.style.display = "none";

    myConsultsBtn.addEventListener('click', function(e) {
        e.preventDefault();

        // Toggle active and non-active classes
        myConsultsBtn.classList.add("active");
        myConsultsBtn.classList.remove("non-active");
        allConsultsBtn.classList.add("non-active");
        allConsultsBtn.classList.remove("active");

        // Toggle display
        myConsults.style.display = "block";
        allConsults.style.display = "none";
    });



    // editButtons.forEach(function(editButton) {
    //   editButton.addEventListener("click", function(event) {
    //     event.preventDefault();

    //     const editFormId = "editForm_" + editButton.id.split("_")[1];
    //     const editForm = document.getElementById(editFormId);

    //     if (editForm.style.display === "none" || editForm.style.display === "") {
    //       editForm.style.display = "block";
    //     } else {
    //       editForm.style.display = "none";
    //     }
    //   });
    // });
  }

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
