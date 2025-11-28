
output "nlb_arn" {
  description = "The ARN of the load balancer"
  value       = aws_lb.nlb.arn
}
output "nlb_dns_name" {
  description = "The DNS name of the load balancer"
  value       = aws_lb.nlb.dns_name

}
output "nlb_zone_id" {
  description = "The Route 53 zone ID of the load balancer"
  value       = aws_lb.nlb.zone_id
}