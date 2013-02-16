//= require jquery.alerts/jquery.alerts
//= require_self

var creditCardDeleteCallback=$.noop();

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

  creditCardDeleteCallback();
}


function paymentPageResetCreditCardOptions() {
  // if we don't do this, we'll accidentally submit our 'use existing'
  // id and we won't use a new card
  $("#existing_cards input[type=radio]:checked:hidden").removeAttr('checked');

  // if we select a card, we enable the continue button, but if we then
  // delete it, we need to restore the button back to it's disabled state
  // did we just delete the last card?
  if ($('.existing-credit-card-list tbody tr:visible').length == 0) {
    $('#card_options').hide();
    $('#existing_cards').hide();

    // 'new card'is our only option now
    $('#use_existing_card_no').click();
    // restoreContinueButton();
  } else {
    useExistingCardsInit();
  }
}

$(document).on('click', '#use_existing_card_no', function () {
                                       // why am i having to hide the contents of the div as well???
                                       $("#existing_cards").hide();
                                       $("#existing_cards h4").hide();
                                       $("#existing_cards table").hide();

                                       $("[data-hook=card_number]").show();
                                       $("[data-hook=card_expiration]").show();
                                       $("[data-hook=cart_code]").show(); // unfortunately this is a typo in spree (cart v card)

                                       restoreContinueButton();

  // if we don't do this, we'll accidentally submit our 'use existing'
  // id and we won't use a new card
  $("#existing_cards input[type=radio]:checked").removeAttr('checked');

});

$(document).on('click', '#use_existing_card_yes', function () {
  useExistingCardsInit();
});

$(document).on('change', 'input[type=radio][name=existing_card]',function () {
                                                  if ($(this).is(':checked')) {
                                                    restoreContinueButton();
                                                  }
                                                }
                                               );

// when we select a different payment method, make sure we re-enable the continue button
// so find every payment method radio that's not a credit card method

$(document).on('click','input[type="radio"][name="order[payments_attributes][][payment_method_id]"]', function() {
  ($('#payment-methods li')).hide();
  if (this.checked) {
    // why doesn't this work????
    // if ($.contains($('#payment_method_' + this.value),$('#card_notice'))) {
    // if ($('#payment_method_' + this.value).find('#card_notice').length > 0) {
    if ($('.existing-credit-card-list').length > 0) {
      disableContinueButton();
    } else {
      restoreContinueButton();
    }

    return ($('#payment_method_' + this.value)).show();
  }
});


function restoreContinueButton() {
  $(".form-buttons input[type=submit]").attr('disabled',false);
  $(".form-buttons input[type=submit]").val(original_button_text);
}

function useExistingCardsInit() {
  $("#existing_cards").show();
  $("#existing_cards h4").show();
  $("#existing_cards table").show();

  $("[data-hook=card_number]").hide();
  $("[data-hook=card_expiration]").hide();
  $("[data-hook=cart_code]").hide(); // unfortunately this is a typo in spree (cart v card)

  disableContinueButton();
}

function disableContinueButton() {
  if ($("#existing_cards input[type=radio]:checked").length == 0) {
    // temporarily rename & disable the save button if no cards are selected
    $(".form-buttons input[type=submit]").attr('disabled',true);
    $(".form-buttons input[type=submit]").val('Please Select a Card to Use');
  }
}
