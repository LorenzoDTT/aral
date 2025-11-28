# Introduction

This terraform module can be used as global customization to enforce corporate password policy in AWS accounts.
Altough IAM users is not a good AWS security practice, some use cases required the creation of IAM users, therefore, it is important to enforce the password policy in AWS accounts so that IAM users created will set up passwords that comply the corporate policy.
