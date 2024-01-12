import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="feed-actions"
export default class extends Controller {
  handleFavorite(event){
    if (event.currentTarget.classList.contains('fa-regular')) {
      event.currentTarget.classList.remove('fa-regular');
      event.currentTarget.classList.add('fa-solid');
      event.currentTarget.setAttribute('data-bs-original-title', 'Remove from Favorites');
      event.currentTarget.setAttribute('aria-label', 'Remove from Favorites');
    } else {
      event.currentTarget.classList.add('fa-regular');
      event.currentTarget.classList.remove('fa-solid');
      event.currentTarget.setAttribute('data-bs-original-title', 'Mark favorite');
      event.currentTarget.setAttribute('aria-label', 'Mark favorite');
    }
  }

  showLatestFeed(event) {
    toastr.options = {
      "closeButton": false,
      "debug": false,
      "newestOnTop": false,
      "progressBar": true,
      "positionClass": "toast-top-right",
      "preventDuplicates": false,
      "onclick": null,
      "showDuration": "300",
      "hideDuration": "9000",
      "timeOut": "2000",
      "extendedTimeOut": "1000",
      "showEasing": "swing",
      "hideEasing": "linear",
      "showMethod": "fadeIn",
      "hideMethod": "fadeOut",
      "onHidden": function() {
        window.location.reload();
      }
    };

    toastr["success"]("Wait! New feeds are loading....");
  }

}
