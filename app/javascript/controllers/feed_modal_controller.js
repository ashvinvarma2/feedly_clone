import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal"];

  showModal(event) {
    const feedData = JSON.parse(event.currentTarget.dataset.feedData);
    document.getElementById('feedTitle').innerHTML = feedData.title;
    document.getElementById('feedPageTitle').innerHTML = feedData.page_title;
    document.getElementById('feedTime').innerHTML = feedData.pub_date;

    const feedImage = document.getElementById('feedImage');
    feedImage.innerHTML = `<img src="${feedData.image_url}" width="100%" height="400px" alt="Feed Image" />`;

    document.getElementById('feedDescription').innerHTML = feedData.description;

    const feedVisitURL = document.getElementById('feedVisitURL');
    feedVisitURL.innerHTML = `<a class='visit-button' target="_blank" href="${feedData.article_link}">VISIT WEBSITE</a>`;
  }
}
