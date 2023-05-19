import $ from "jquery";
import axios from "axios";
import { csrfToken } from "rails-ujs";

axios.defaults.headers.common["X-CSRF-Token"] = csrfToken();

document.addEventListener("DOMContentLoaded", () => {
  const dataset = $("#post-show").data();
  const postId = dataset.postId;

  axios.get(`/posts/${postId}/comments`).then((response) => {
    const comments = response.data;
    comments.forEach((comment) => {
      $(".comment").append(
        `<div class="comment__item">
          <div class="comment__left">
          </div>
          <div class="comment__right">
            <p class="comment__content">${comment.content}</p>
          </div>
        </div>`
      );
    });

    $(".js-add-comment-btn").on("click", () => {
      const content = $("#comment_content").val();
      if (!content) {
        window.alert("コメントを入力してください");
      } else {
        axios
          .post(`/posts/${postId}/comments`, {
            comment: { content: content },
          })
          .then((response) => {
            const comment = response.data;
            $(".comment").append(
              `<div class="comment__item">
              <div class="comment__left">
              </div>
              <div class="comment__right">
                <p class="comment__content">${comment.content}</p>
              </div>
            </div>`
            );
            $("#comment_content").val("");
          });
      }
    });
  });
});
