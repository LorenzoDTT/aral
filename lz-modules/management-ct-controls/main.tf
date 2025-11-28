# management_ct_controls/main.tf

resource "aws_controltower_control" "guardrails" {

  for_each = { for control in local.guardrails_list : join(":", [keys(control)[0], values(control)[0]]) => [keys(control)[0], values(control)[0]] }

  control_identifier = each.value[0]

  target_identifier = local.ous_id_to_arn_map[each.value[1]]

}