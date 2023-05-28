import $ from 'jquery';
import axios from 'modules/axios';

document.addEventListener('DOMContentLoaded', () => {
  const dataset = $('#account-show').data();
  const userId = dataset.userId;

  axios.get(`/accounts/${userId}/follow`).then((response) => {
    const hasFollowed = response.data.hasFollowed;
    if (hasFollowed) {
      $('.js-unfollow-text').removeClass('hidden');
    } else {
      $('.js-follow-text').removeClass('hidden');
    }

    const followersNumber = response.data.followersNumber;
    const appendFollowersNumber = () => {
      $('.js-followers-number').append(`<div>${followersNumber}</div>`);
    };
    appendFollowersNumber();
  });

  $('.js-follow-text').on('click', () => {
    axios.post(`/accounts/${userId}/follow`).then((response) => {
      if (response.data.status === 'ok') {
        $('.js-follow-text').addClass('hidden');
        $('.js-unfollow-text').removeClass('hidden');
      }

      const followersNumber = response.data.followersNumber;
      const htmlFollowersNumber = () => {
        $('.js-followers-number').html(`<div>${followersNumber}</div>`);
      };
      htmlFollowersNumber();
    });
  });

  $('.js-unfollow-text').on('click', () => {
    axios.post(`/accounts/${userId}/unfollow`).then((response) => {
      if (response.data.status === 'ok') {
        $('.js-unfollow-text').addClass('hidden');
        $('.js-follow-text').removeClass('hidden');
      }

      const followersNumber = response.data.followersNumber;
      const htmlFollowersNumber = () => {
        $('.js-followers-number').html(`<div>${followersNumber}</div>`);
      };
      htmlFollowersNumber();
    });
  });
});
