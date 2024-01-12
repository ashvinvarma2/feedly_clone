import { Controller } from "@hotwired/stimulus"
import 'popper.js'
import * as bootstrap from "bootstrap"

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

  newBoard(event) {
    var articleId = event.target.closest("a").dataset.articleId;
    var boardModal = document.getElementById('boardModal');
    var modal = new bootstrap.Modal(boardModal);

    jQuery.ajax({
      type: "GET",
      url: `/boards/new/`,
      data: { article_id: articleId},
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

  reloadBoard() {
    window.location.reload();
  }

  clearInput() {
    var titleInput = document.getElementById("board_title_input");
    var descriptionInput = document.getElementById("board_description")
    var saveButton = document.getElementById("create_board_button");

    saveButton.disabled = true;
    titleInput.value = '';
    descriptionInput.value = '';

    titleInput.addEventListener('input', function() {
      saveButton.disabled = titleInput.value.trim() === '';
    });
  }
}
