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


$('#use_existing_card_no').live('click', function () {
                                       // why am i having to hide the contents of the div as well???
                                       $("#existing_cards").hide();
                                       $("#existing_cards h4").hide();
                                       $("#existing_cards table").hide();

                                       $("[data-hook=card_number]").show();
                                       $("[data-hook=card_expiration]").show();
                                       $("[data-hook=cart_code]").show(); // unfortunately this is a typo in spree (cart v card)

                                       restoreContinueButton();
});
$('#use_existing_card_yes').live('click', function () {
                                       $("#existing_cards").show();
                                       $("#existing_cards h4").show();
                                       $("#existing_cards table").show();

                                       $("[data-hook=card_number]").hide();
                                       $("[data-hook=card_expiration]").hide();
                                       $("[data-hook=cart_code]").hide();
});

$('input[type=radio][name=existing_card]').live('change',function () {
                                                  if ($(this).is(':checked')) {
                                                    restoreContinueButton();
                                                  }
                                                }
                                               );

function restoreContinueButton() {
  $(".form-buttons input[type=submit]").attr('disabled',false);
  $(".form-buttons input[type=submit]").val(original_button_text);
}