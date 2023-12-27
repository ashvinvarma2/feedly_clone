import { Controller } from "@hotwired/stimulus"
import 'popper.js'
import * as bootstrap from "bootstrap"

export default class extends Controller {
  static targets = ["feedLayout", "feedActions"];

  connect() {
    this.feedLayoutTarget.addEventListener("mouseenter", this.showActions.bind(this));
  }

  showModal(event) {

    if (!event.target.closest('.bookmark-icons')) {
      var articleId = this.feedLayoutTarget.dataset.articleId;
      var feedModal = document.getElementById('feedModal');
      var modal = new bootstrap.Modal(feedModal);

      jQuery.ajax({
        type: "GET",
        url: `/rss_feeds/show_article/${articleId}`,
        data: { },
        dataType: "script",
        success(data) {
          modal.show();
          return false;
        },
        error(data) {
          return false;
        }
      })
    }
  }

  markRead(event){
    event.target.classList.toggle('marked-read');
    if (event.target.classList.contains('marked-read')) {
      event.currentTarget.querySelector("i").setAttribute('data-bs-original-title', 'Mark Unread');
      event.currentTarget.querySelector("i").setAttribute('aria-label', 'Mark Unread');
    } else {
      event.currentTarget.querySelector("i").setAttribute('data-bs-original-title', 'Mark Read');
      event.currentTarget.querySelector("i").setAttribute('aria-label', 'Mark Read');
    }

  }

  markReadAndHide(event){
    document.querySelector('.tooltip').remove()
    this.feedLayoutTarget.remove();
  }

  showActions(event){
    this.feedActionsTarget.style.display = "flex";
    this.feedLayoutTarget.addEventListener("mouseleave", this.hideActions.bind(this));
    const popover = document.querySelector('.custom-popover.board-popover');
    if (popover) {
      popover.remove();
    }
  }

  hideActions(event){
    const popover = document.querySelector('.custom-popover.board-popover');
    var relatedTarget = event.relatedTarget;

    if (relatedTarget) {
      var popoverElement = this.closestByClass(relatedTarget, 'popover');
      if (!popoverElement) {
        this.feedActionsTarget.style.display = "none";
      }
    }
  }

  closestByClass(el, className) {
    while (el && !el.classList.contains(className)) {
      el = el.parentElement;
    }
    return el;
  }
}
