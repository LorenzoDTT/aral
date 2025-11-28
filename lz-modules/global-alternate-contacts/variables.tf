variable "resource_sufix" {
  type        = string
  description = "Sufix name for the resource"
  default = "aod-alternate-contacts"
}

variable "contacts" {
  type        = map(any)
  description = "List of events and target email addresses"
  default = {
    OPERATIONS = {
      name          = "Juan José Seco Rodríguez"
      title         = "Cloud Ops Manager phone number and Ops mailbox"
      email_address = "jsr@armandoalvarez.com"
      phone_number  = "+34609853569"
    }
    BILLING = {
      name          = "Pablo Sanz Díez"
      title         = "Contract Manager phone number and Billing mailbox"
      email_address = "psd@armandoalvarez.com"
      phone_number  = "+34617046675"
    }
    SECURITY = {
      name = "Raúl García Suárez"
      title = "Security Manager phone number and mailbox"
      email_address = "rgarcia@armandoalvarez.com"
      phone_number = "+34609055167"
    }
  }
}
