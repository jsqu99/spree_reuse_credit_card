//= require store/spree_core
//= require jquery.alerts/jquery.alerts
//= require_self

function displayCreditCardDeleteStatus(notice) {
  notice_div = $('.flash.notice');

  if (notice) {
    if (notice_div.length > 0) {
      notice_div.html(notice);
      notice_div.show();
    } else {
      $("#card_notice").html('<div class="flash notice">' + notice + '</div>');
    }
  }
}
