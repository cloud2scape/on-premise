output "nat_interface_network_interface_id" {
    value = aws_instance.nat_instance.primary_network_interface_id
  
}

output "web1_id" {
    value = aws_instance.web1.id
  
}

output "web2_id" {
    value = aws_instance.web2.id
  
}