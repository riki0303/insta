import $ from "jquery";
import axios from "axios";
import { csrfToken } from "rails-ujs";

axios.defaults.headers.common["X-CSRF-Token"] = csrfToken();

const handleLikeDisplay = (hasLiked) => {
  if (hasLiked) {
    $(".like-active").removeClass("hidden");
  } else {
    $(".like-inactive").removeClass("hidden");
  }
};

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

  axios.get(`/posts/${postId}/like`).then((response) => {
    const hasLiked = response.data.hasLiked;
    handleLikeDisplay(hasLiked);
  });

  $(".like-inactive").on("click", () => {
    axios
      .post(`/posts/${postId}/like`)
      .then((response) => {
        if (response.data.status === "ok") {
          $(".like-active").removeClass("hidden");
          $(".like-inactive").addClass("hidden");
        }
      })
      .catch((e) => {
        window.alert("error!!!");
        console.log(e);
      });
  });

  $(".like-active").on("click", () => {
    axios
      .delete(`/posts/${postId}/like`)
      .then((response) => {
        if (response.data.status === "ok") {
          $(".like-active").addClass("hidden");
          $(".like-inactive").removeClass("hidden");
        }
      })
      .catch((e) => {
        window.alert("error!!!");
        console.log(e);
      });
  });
});
