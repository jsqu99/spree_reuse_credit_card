SpreeReuseCreditCard
====================

This is not spree 1.2 ready yet.  Working on it.
This extension enables view enhancements for managing multiple previously-used credit cards for Spree.

It adds a user/accounts section listing the current credit cards on file.

On the payment screen it adds a 'reuse this card' section as well.

It is to be used in conjunction with an appropriate payment-profile-enabled, spree-supported payment processor (e.g. Authorize.net CIM, USA-EPay, Stripe(coming soon))

It is currently very much a work in progress!

Please feel free to contact me (via github issues) with any issues you may have.

Installation
============
    bundle exec rails g spree_reuse_credit_card:install

Copyright (c) 2011 Jeffrey D. Squires, released under the New BSD License
