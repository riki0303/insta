import $ from "jquery";
import axios from "modules/axios";

document.addEventListener("DOMContentLoaded", () => {
  const dataset = $("#account-show").data();
  const userId = dataset.userId;

  axios.get(`/accounts/${userId}/follow`).then((response) => {
    const hasFollowed = response.data.hasFollowed;
    if (hasFollowed) {
      $(".js-unfollow-text").removeClass("hidden");
    } else {
      $(".js-follow-text").removeClass("hidden");
    }
  });
});
