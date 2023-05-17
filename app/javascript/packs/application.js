// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start();
require("turbolinks").start();
require("@rails/activestorage").start();
require("channels");

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

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

document.addEventListener("turbolinks:load", () => {
  const dataset = $("#post-show").data();
  const postId = dataset.postId;
  axios.get(`/posts/${postId}/like`).then((response) => {
    const hasLiked = response.data.hasLiked;
    handleLikeDisplay(hasLiked);
  });

  $(".like-inactive").on("click", () => {
    axios
      .post(`/posts/${postId}/like`)
      .then((response) => {
        window.alert("OK!!");
        console.log(response);
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
        window.alert("OK!!");
        console.log(response);
      })
      .catch((e) => {
        window.alert("error!!!");
        console.log(e);
      });
  });
});
