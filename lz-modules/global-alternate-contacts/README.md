# Introduction
# Module to update alternate contacts in all accounts

This global module automates the management of alternate contacts for Operations, Billing and Security teams on accounts in the landing zone

## Reference:

https://docs.aws.amazon.com/accounts/latest/reference/manage-acct-update-contact.html


## List of resources

This module is called using this code in the main.tf file in each account:
module "alternate_contacts" {
  source         = "github.com/LorenzoDTT/aral/global-alternate-contacts"
  resource_sufix = "alternate-contacts"
}

Also, you had to use the variables.tf file inside the module to configure the contacts.

This is the list of resources created by this module:
* `contacts`: aws_account_alternate_contact containing the contact information (name, title, email and phone number) of each team.