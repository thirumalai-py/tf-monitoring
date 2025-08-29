# ------------------ Outputs Web ------------------

output "web_public_ip" {
  value = aws_instance.web.public_ip
}

output "web_instance_id" {
  value = aws_instance.web.id
}

# ------------------ Outputs DB ------------------
output "db_public_ip" {
  value = aws_instance.db.public_ip
}

output "db_instance_id" {
  value = aws_instance.db.id
}