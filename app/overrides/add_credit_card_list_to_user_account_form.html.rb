Deface::Override.new(
                     :name => 'add_credit_card_list_to_user_account_form',
                     :virtual_path => 'users/show',
                     :insert_after => '[data-hook=account_my_orders]',
                     :partial =>'users/card_admin'
)
