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

      if (dropdownLink) {
        event.preventDefault();

        // Close any open dropdown
        if (openDropdown) {
          openDropdown.classList.remove("show");
          openDropdown.remove();
        }

        var dropdownMenu = buildDropdown(dropdownLink);
        dropdownMenu.style.position = "fixed";
        dropdownMenu.style.left = `${event.clientX}px`;
        dropdownMenu.style.top = `${event.clientY}px`;

        // Show the dropdown
        dropdownMenu.classList.add("show");
        openDropdown = dropdownMenu;

        if (document.getElementById('add-favorite') !== null ){
          document.getElementById('add-favorite').addEventListener('click', function(event) {
            document.querySelectorAll(`.dropdown-link[data-id="${dropdownLink.dataset.id}"][data-class="${dropdownLink.dataset.class}"]`).forEach((element, index) => {
              element.dataset.markedFavorite = "true";
            });
          });
        }

        if (document.getElementById('remove-favorite') !== null ){
          document.querySelector('#remove-favorite').addEventListener('click', function(event) {
            document.querySelectorAll(`.dropdown-link[data-id="${dropdownLink.dataset.id}"][data-class="${dropdownLink.dataset.class}"]`).forEach((element, index) => {
              element.dataset.markedFavorite = "false";
            });
          });
        }

        // Close the dropdown when clicking outside of it
        var formElement = dropdownLink.parentElement.parentElement.querySelector(".rename-form")
        body.addEventListener("click", function clickOutside(event) {
          if (formElement) {
            if (!dropdownLink.contains(event.target) && !dropdownMenu.contains(event.target)) {
              if (!(formElement  && formElement.contains(event.target))) {
                dropdownMenu.classList.remove("show");
                body.removeEventListener("click", clickOutside);
                openDropdown = null;
                dropdownMenu.remove();
                if (!dropdownLink.classList.contains("rss-feed-level")) {
                  toggleForm(dropdownLink, "close");
                }
              }
            }
          } else {
            if (!dropdownLink.contains(event.target) && !dropdownMenu.contains(event.target)) {
              dropdownMenu.classList.remove("show");
              body.removeEventListener("click", clickOutside);
              openDropdown = null;
              dropdownMenu.remove();
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
      var favoritable_id = dropdownLink.dataset.id;
      var favoritable_class = dropdownLink.dataset.class;
      var markedFavorite = dropdownLink.dataset.markedFavorite;

      var item = ""

      if (!dropdownLink.classList.contains('rss-feed-level')) {
        item += `<li class="rename-category">
                      <div class="category-name">
                        <i class="fa fa-i-cursor folder-icon"></i>
                        <span>Rename</span>
                      </div>
                    </li>`
      }

      if (markedFavorite === 'true') {
        item += `<a id="remove-favorite" style="text-decoration: none;" data-turbo-stream="true" href="/favorites/handle_favorite?favoritable_id=${favoritable_id};favoritable_type=${favoritable_class}">
                   <li class="remove-from-favorite">
                     <div class="category-name">
                       <i class="fa-solid fa-heart folder-icon"></i>
                       <span>Remove from Favorite</span>
                     </div>
                   </li>
                 </a>`
      } else {
        item += `<a id="add-favorite" style="text-decoration: none;" data-turbo-stream="true" href="/favorites/handle_favorite?favoritable_id=${favoritable_id};favoritable_type=${favoritable_class}">
                   <li class="add-to-favorite">
                     <div class="category-name">
                        <i class="fa-regular fa-heart folder-icon"></i>
                        <span>Add to Favorite</span>
                     </div>
                   </li>
                 </a>`
      }

      if (dropdownLink.classList.contains('category-level')) {
        item += `<a style="text-decoration: none;" data-turbo-stream="true" data-turbo-method="DELETE" href="/categories/${favoritable_id}">
                   <li>
                     <div class="category-name">
                     <i class="fa-regular fa-trash-can folder-icon"></i>
                        <span>Delete</span>
                     </div>
                   </li>
                 </a>`
      } else if (dropdownLink.classList.contains('board-level')) {
        item += `<a style="text-decoration: none;" data-turbo-stream="true" data-turbo-method="DELETE" href="/boards/${favoritable_id}">
                   <li>
                     <div class="category-name">
                     <i class="fa-regular fa-trash-can folder-icon"></i>
                       <span>Delete</span>
                     </div>
                   </li>
                 </a>`
      } else if (dropdownLink.classList.contains('rss-feed-level')) {
        item += `<a style="text-decoration: none;" data-turbo-stream="true" href="/rss_feeds/unfollow/${favoritable_id}">
                   <li>
                     <div class="category-name">
                     <i class="fa-regular fa-trash-can folder-icon"></i>
                       <span>Unfollow</span>
                     </div>
                   </li>
                 </a>`
      }

      dropdownMenu.innerHTML += item;

      dropdownMenu.querySelectorAll("li").forEach(function(item) {
        item.addEventListener("click", function() {
          dropdownMenu.classList.remove("show");
          openDropdown = null;

          // Remove the dynamically created dropdown element
          dropdownMenu.remove();

          if (this.classList.contains("rename-category")){
            toggleForm(dropdownLink, "open");
          }
        });
      });

      // Append the dropdown menu to the document body
      body.appendChild(dropdownMenu);

      return dropdownMenu;
    }

    function toggleForm(dropdownLink, action) {
      var categoryElement = dropdownLink.parentElement
      if (dropdownLink.classList.contains('category-level')) {
        var formElement = categoryElement.parentElement.querySelector('.category-rename-form');
      } else if (dropdownLink.classList.contains('board-level')) {
          var formElement = categoryElement.parentElement.querySelector('.board-rename-form');
      } else if (dropdownLink.classList.contains('rss-feed-level')) {
        var formElement = categoryElement.nextElementSibling;
      }

      if (action === "close") {
        categoryElement.style.display = "block";
        formElement.style.display = "none";
      } else if (action === "open") {
        categoryElement.style.display = "none";
        formElement.style.display = "block ";
        var categoryInput = formElement.querySelector(".category-text-field")
        categoryInput.focus();
        categoryInput.setSelectionRange(categoryInput.value.length, categoryInput.value.length);
        categoryInput.value = categoryElement.dataset.name;
      }
    }
  }
}
