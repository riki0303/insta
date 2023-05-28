import $ from 'jquery';
import axios from 'modules/axios';

const appendNewComment = (comment) => {
  $('.comment').append(
    `<div class= "comment__item">
      <div class= "comment__left">
        <a class = "comment__avatar-container" href= "/accounts/${comment.user_id}">
          <img src="${comment.user_avatar}" class="comment__avatar" alt="User Avatar"></img>
        </a>
      </div>
      <div class= "comment__right">
        <a class = "comment__account" href= "/accounts/${comment.user_id}">
          <div class = "comment__account">${comment.user_account}</div>
        </a>
        <p class= "comment__content">${comment.content}</p>
      </div>
    </div>`
  );
};

document.addEventListener('DOMContentLoaded', () => {
  const dataset = $('#post-show').data();
  const postId = dataset.postId;

  axios.get(`/posts/${postId}/comments`).then((response) => {
    const comments = response.data;
    comments.forEach((comment) => {
      appendNewComment(comment);
    });

    $('.js-add-comment-btn').on('click', () => {
      const content = $('#comment_content').val();
      if (!content) {
        window.alert('コメントを入力してください');
      } else {
        axios
          .post(`/posts/${postId}/comments`, {
            comment: { content: content },
          })
          .then((response) => {
            const comment = response.data;
            appendNewComment(comment);
            $('#comment_content').val('');
          });
      }
    });
  });
});
