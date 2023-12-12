import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="general"
export default class extends Controller {
  saveReadLater(event){
    if (event.currentTarget.classList.contains('fa-regular')) {
      event.currentTarget.classList.remove('fa-regular');
      event.currentTarget.classList.add('fa-solid');
    } else {
      event.currentTarget.classList.add('fa-regular');
      event.currentTarget.classList.remove('fa-solid');
    }

    this.updateAtFeedsPage(event)
  }

  updateAtFeedsPage(event){
    var articleId = event.currentTarget.dataset.articleId
    var read_later_target = document.getElementById(`read_later_article_${articleId}`);
    if (articleId && read_later_target) {
      if (read_later_target.classList.contains('fa-regular')) {
        read_later_target.classList.remove('fa-regular');
        read_later_target.classList.add('fa-solid');
      } else {
        read_later_target.classList.add('fa-regular');
        read_later_target.classList.remove('fa-solid');
      }
    }
  }
}
