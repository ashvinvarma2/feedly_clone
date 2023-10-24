// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import 'popper.js'
import * as bootstrap from "bootstrap"

import jquery from 'jquery'
window.jQuery = jquery
window.$ = jquery

const myDefaultAllowList = bootstrap.Popover.Default.allowList
myDefaultAllowList.a = ['target', 'href', 'title', 'rel', 'data-method', 'data-turbo-stream', 'data-bs-trigger', 'tabindex']
myDefaultAllowList.span = ['data-action', 'data-view', 'data-view-switcher-target']
myDefaultAllowList.ul = ['data-controller']

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

// Here we're handling the popovers
document.addEventListener('mouseover', (event) => {
  const target = event.target;

  if (target.dataset.bsToggle === 'popover') {
    const popover = document.querySelector('.popover'); // Assuming the popover element has a class 'popover'
    if (!popover) {
      new bootstrap.Popover(target, {
        html: true
      });
    }
  };

  if (target.classList.contains('add-button')) {
    target.addEventListener('click', function() {
      var popover = document.querySelector('.custom-popover');
      if (popover) {
        popover.remove();
      }
    });
  }
});

const popoverTriggerList = document.querySelectorAll('[data-bs-toggle="popover"]')
const popoverList = [...popoverTriggerList].map(popoverTriggerEl => new bootstrap.Popover(popoverTriggerEl, {html: true}))

// const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]')
// const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl))

var menuContainer = document.querySelector('.navbar-container');
var menuBtn = document.querySelector('.navbar-header .logo .logoImg i');
var body = document.querySelector('body');
var toggleBtn = document.querySelector('.btn-container .button');
var darkModeText = document.querySelector('.dark-light-mode .text');

toggleBtn.addEventListener('click', darkMode);

function menuToggle(){
  menuContainer.classList.toggle('active');
}

// Loaders
document.addEventListener("turbo:before-fetch-request", () => {
  document.getElementById("loader").style.display = "block";
});

document.addEventListener("turbo:before-fetch-response", () => {
  document.getElementById("loader").style.display = "none";
});

if (JSON.parse(localStorage.getItem("darkModeoOn")) == true) {
  toggleBtn.classList.toggle('active');
  body.classList.toggle('active');
}
function darkMode(){
  localStorage.setItem("darkModeoOn", !(JSON.parse(localStorage.getItem("darkModeoOn"))));
  toggleBtn.classList.toggle('active');
  body.classList.toggle('active');
  if(darkModeText.innerHTML == 'Light Mode'){
    darkModeText.innerHTML = 'Dark Mode';
  }
  else{
    darkModeText.innerHTML = 'Light Mode';
  }
}

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