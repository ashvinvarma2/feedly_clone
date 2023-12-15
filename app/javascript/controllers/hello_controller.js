import { Controller } from "@hotwired/stimulus"
import 'popper.js'
import * as bootstrap from "bootstrap"

export default class extends Controller {
  static targets = ["body"];

  connect() {
    var menuContainer = document.querySelector('.navbar-container2');
    var menuBtn = document.querySelector('.navbar-header .logo .logoImg.slider svg');
    menuBtn.addEventListener('click', menuToggle);

    function menuToggle(){
      menuContainer.classList.toggle('active');
    }

    // Here we're handling the popovers
    const myDefaultAllowList = bootstrap.Popover.Default.allowList
    myDefaultAllowList.a = ['target', 'href', 'title', 'rel', 'data-method', 'data-turbo-stream', 'data-bs-trigger', 'tabindex', 'data-action', 'data-view', 'data-turbo-method']
    myDefaultAllowList.span = ['data-action', 'data-view', 'data-view-switcher-target']
    myDefaultAllowList.ul = ['data-controller']

    const popoverTriggerList = document.querySelectorAll('[data-bs-toggle="popover"]');
    [...popoverTriggerList].map(popoverTriggerEl => new bootstrap.Popover(popoverTriggerEl, {html: true}));

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
        var rssLink = document.getElementById("follow-button").dataset.rssLink
        try {
          var url = new URL(target.href);

          // Check if the rss-link parameter is already present
          if (!url.searchParams.has('rss_link')) {
            // Add the rss-link query parameter to the existing href
            url.searchParams.append('rss_link', rssLink);
            target.href = url.toString();
          }
        } catch (error) {
          console.error("Error parsing URL:", error);
        }
      }
    });
    // Here we're ended the popovers handling
  }
}
