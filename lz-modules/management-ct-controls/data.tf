
data "aws_caller_identity" "context" {}

data "aws_region" "current" {}

data "aws_organizations_organization" "organization" {}

# Get OUs data resources up to five levels of OUs deep under a root (maximum nesting quota limit)
data "aws_organizations_organizational_units" "root" {
  parent_id = data.aws_organizations_organization.organization.roots[0].id
}
data "aws_organizations_organizational_units" "ous_depth_1" {
  for_each  = toset([for x in data.aws_organizations_organizational_units.root.children : x.id])
  parent_id = each.key
  depends_on = [
    data.aws_organizations_organizational_units.root
  ]
}
data "aws_organizations_organizational_units" "ous_depth_2" {
  for_each  = toset([for y in flatten([for x in data.aws_organizations_organizational_units.ous_depth_1 : x.children]) : y.id])
  parent_id = each.key
  depends_on = [
    data.aws_organizations_organizational_units.ous_depth_1
  ]
}
data "aws_organizations_organizational_units" "ous_depth_3" {
  for_each  = toset([for y in flatten([for x in data.aws_organizations_organizational_units.ous_depth_2 : x.children]) : y.id])
  parent_id = each.key
  depends_on = [
    data.aws_organizations_organizational_units.ous_depth_2
  ]
}
data "aws_organizations_organizational_units" "ous_depth_4" {
  for_each  = toset([for y in flatten([for x in data.aws_organizations_organizational_units.ous_depth_3 : x.children]) : y.id])
  parent_id = each.key
  depends_on = [
    data.aws_organizations_organizational_units.ous_depth_3
  ]
}