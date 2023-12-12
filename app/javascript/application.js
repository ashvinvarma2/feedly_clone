// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import 'popper.js'
import * as bootstrap from "bootstrap"

import jquery from 'jquery';
window.jQuery = jquery;
window.$ = jquery;

import "toastr"
window.toastr = require("toastr")
window.$ = require("toastr")

const myDefaultAllowList = bootstrap.Popover.Default.allowList
myDefaultAllowList.a = ['target', 'href', 'title', 'rel', 'data-method', 'data-turbo-stream', 'data-bs-trigger', 'tabindex']
myDefaultAllowList.span = ['data-action', 'data-view', 'data-view-switcher-target']
myDefaultAllowList.ul = ['data-controller']

// Toastr Library
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
  "hideMethod": "fadeOut"
}


// Tooptips
document.addEventListener('mouseover', (event) => {
  const target = event.target;

  if (target.dataset.bsToggle === 'tooltip') {
    const tooltip = new bootstrap.Tooltip(target);
    tooltip.show();

    target.addEventListener('mouseout', () => {
      tooltip.hide();
    });
  }
});

const popoverTriggerList = document.querySelectorAll('[data-bs-toggle="popover"]')
const popoverList = [...popoverTriggerList].map(popoverTriggerEl => new bootstrap.Popover(popoverTriggerEl, {html: true}))

// const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]')
// const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl))

var body = document.querySelector('body');

// Loaders
document.addEventListener("turbo:before-fetch-request", () => {
  document.getElementById("loader").style.display = "block";
});

document.addEventListener("turbo:before-fetch-response", () => {
  document.getElementById("loader").style.display = "none";
});



// // Get all anchor tags on the page
// const anchorTags = document.querySelectorAll('a');

// // Define a function to handle click events
// function handleClick(event) {
//   // Prevent the default behavior of the anchor tag (e.g., navigating to a new page)
//   event.preventDefault();

//   // Add your specific class to the clicked anchor tag
//   this.classList.add('selected-link');
// }

// // Add a click event listener to each anchor tag
// anchorTags.forEach(function(anchor) {
//   anchor.addEventListener('click', handleClick);
// });
