import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["feedLayout", "feedActions", "modal"];

  connect() {
    this.feedLayoutTarget.addEventListener("mouseenter", this.showActions.bind(this));
  }

  showModal(event) {
    const feedData = JSON.parse(event.currentTarget.dataset.feedData);

    document.getElementById('readLater').innerHTML =
      `<a data-turbo-stream="top" href='/rss_feeds/save_read_later?article_id=${feedData.id}&amp;id=${feedData.rss_feed_id}'>
         <i class="${feedData.read_later ? 'fa-solid' : 'fa-regular'} fa-bookmark" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Read Later" data-action="click->feed-modal#saveReadLater"></i>
       </a>`
    document.getElementById('feedTitle').innerHTML = feedData.title;
    document.getElementById('feedPageTitle').innerHTML = feedData.page_title;
    document.getElementById('feedTime').innerHTML = feedData.pub_date;

    const feedImage = document.getElementById('feedImage');
    feedImage.innerHTML = `<img src="${feedData.image_url}" width="100%" height="400px" alt="Feed Image" />`;

    document.getElementById('feedDescription').innerHTML = feedData.description;

    const feedVisitURL = document.getElementById('feedVisitURL');
    feedVisitURL.innerHTML = `<a class='visit-button' target="_blank" href="${feedData.article_link}">VISIT WEBSITE</a>`;
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

  saveReadLater(event){
    if (event.currentTarget.classList.contains('fa-regular')) {
      event.currentTarget.classList.remove('fa-regular');
      event.currentTarget.classList.add('fa-solid');
    } else {
      event.currentTarget.classList.add('fa-regular');
      event.currentTarget.classList.remove('fa-solid');
    }
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
