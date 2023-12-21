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

    // Right click dropdown code starts
    // This is the open a action dropdown in place of a context menu.
    const body = document.body;
    let openDropdown = null;

    body.addEventListener("contextmenu", function(event) {
      const dropdownLink = event.target.closest(".dropdown-link");
      const category_id = dropdownLink.dataset.id

      if (dropdownLink) {
        event.preventDefault();

        // Close any open dropdown
        if (openDropdown) {
          openDropdown.classList.remove("show");
          openDropdown.remove();
        }

        // Build the dropdown dynamically
        if (dropdownLink.classList.contains("category-level")) {
          var dropdownMenu = buildDropdown(dropdownLink);
        } else if (dropdownLink.classList.contains("feed-level")) {
          var dropdownMenu = buildFeedDropdown();
        }

        // Position the dropdown menu at the mouse coordinates
        dropdownMenu.style.position = "fixed";
        dropdownMenu.style.left = `${event.clientX}px`;
        dropdownMenu.style.top = `${event.clientY}px`;

        // Show the dropdown
        dropdownMenu.classList.add("show");
        openDropdown = dropdownMenu;

        // Close the dropdown when clicking outside of it
        body.addEventListener("click", function clickOutside(event) {
          var formElement = dropdownLink.parentElement.parentElement.querySelector(".rename-form")
          if (!dropdownLink.contains(event.target) && !dropdownMenu.contains(event.target)) {
            if (!formElement.contains(event.target)) {
              dropdownMenu.classList.remove("show");
              body.removeEventListener("click", clickOutside);
              openDropdown = null;
              // Remhh bbove the dynamically created dropdown element
              dropdownMenu.remove();
              toggleForm(dropdownLink);
            }
          }
        });
      }
    });

    function buildDropdown(dropdownLink) {
      // Create a new dropdown menu element
      const dropdownMenu = document.createElement("div");
      dropdownMenu.classList.add("dropdown-menu");
      dropdownMenu.classList.add("custom-dropdown");
      dropdownMenu.classList.add("context-menu-dropdown");

      var item = `<li class="rename-category">
                    <div class="category-name">
                      <i class="fa fa-i-cursor folder-icon"></i>
                      <span>Rename</span>
                    </div>
                  </li>`

      dropdownMenu.innerHTML += item;

      dropdownMenu.querySelectorAll("li").forEach(function(item) {
        item.addEventListener("click", function() {
          dropdownMenu.classList.remove("show");
          openDropdown = null;

          // Remove the dynamically created dropdown element
          dropdownMenu.remove();

          if (this.classList.contains("rename-category")){
            toggleForm(dropdownLink);
          }
        });
      });

      // Append the dropdown menu to the document body
      body.appendChild(dropdownMenu);

      return dropdownMenu;
    }

    function toggleForm(dropdownLink) {
      var categoryElement = dropdownLink.parentElement
      var formElement = categoryElement.parentElement.querySelector(".rename-form")
      const formVisible = formElement.style.display !== "none";

      if (formVisible) {
        categoryElement.style.display = "block";
        formElement.style.display = "none";
      } else {
        categoryElement.style.display = "none";
        formElement.style.display = "block ";
        var categoryInput = formElement.querySelector(".category-text-field")
        categoryInput.focus();
        categoryInput.setSelectionRange(categoryInput.value.length, categoryInput.value.length);
        debugger
        categoryInput.value = categoryElement.dataset.name;
      }
    }

    // function buildFeedDropdown() {
    //   // Create a new dropdown menu element
    //   const dropdownMenu = document.createElement("div");
    //   dropdownMenu.classList.add("dropdown-menu");

    //   const dummyItems = ["dsfsdd", "Add To Favorite", "Delete"];
    //   dummyItems.forEach(function(itemText) {
    //     const item = document.createElement("a");
    //     item.classList.add("dropdown-item");
    //     item.href = "#";
    //     item.textContent = itemText;
    //     dropdownMenu.appendChild(item);
    //   });

    //   // Append the dropdown menu to the document body
    //   body.appendChild(dropdownMenu);

    //   return dropdownMenu;
    // }
  }
}
