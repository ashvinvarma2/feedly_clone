import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="view-switcher"
export default class extends Controller {
  connect() {
    console.log("Theme switcher coming ");
    if (JSON.parse(localStorage.getItem("darkModeoOn")) == true) {
      const option = document.getElementById("darkModeBtn").querySelector("i")
      option.classList.remove("fa-circle")
      option.classList.add("fa-circle-dot")
    } else {
      const option = document.getElementById("lightModeBtn").querySelector("i")
      option.classList.remove("fa-circle")
      option.classList.add("fa-circle-dot")
    }
  }

  switchTheme(event) {
    const body = document.querySelector("body");
    if (event.currentTarget.dataset.view == 'dark-theme'){
      localStorage.setItem("darkModeoOn", true);
      body.classList.add('active');
    } else if (event.currentTarget.dataset.view == 'light-theme') {
      localStorage.setItem("darkModeoOn", false);
      body.classList.remove('active');
    }
  }
}
