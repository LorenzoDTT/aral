
# management_ct_controls/locals.tf

locals {

  # Extract Guardrails configuration
  guardrails_list = flatten([
    for i in range(0, length(var.controls)) : [
      for pair in setproduct(element(var.controls, i).control_names, element(var.controls, i).organizational_unit_ids) :
      { "arn:aws:controltower:${data.aws_region.current.name}::control/${pair[0]}" = pair[1] }
    ]
  ])

  ous_depth_1 = [for x in data.aws_organizations_organizational_units.root.children : x]
  ous_depth_2 = flatten([for x in data.aws_organizations_organizational_units.ous_depth_1 : x.children if length(x.children) != 0])
  ous_depth_3 = flatten([for x in data.aws_organizations_organizational_units.ous_depth_2 : x.children if length(x.children) != 0])
  ous_depth_4 = flatten([for x in data.aws_organizations_organizational_units.ous_depth_3 : x.children if length(x.children) != 0])
  ous_depth_5 = flatten([for x in data.aws_organizations_organizational_units.ous_depth_4 : x.children if length(x.children) != 0])

  # Compute map from OU id to OU arn for the whole organization
  ous_id_to_arn_map = { for ou in concat(local.ous_depth_1, local.ous_depth_2, local.ous_depth_3, local.ous_depth_4, local.ous_depth_5) :
    ou.id => ou.arn
  }
}