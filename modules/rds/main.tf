resource "aws_db_instance" "this" {
    instance_class = var.instance_class
    identifier = var.db_name
    engine = "postgres"
    allocated_storage = var.allocated_storage
    username = var.username
    password = var.password
    vpc_security_group_ids = var.vpc_security_gorup_ids
    db_subnet_group_name = aws_db_subnet_group.this.name
    skip_final_snapshot = true

  
}

# resource "aws_db_instance" "this" {
#     engine = "mysql"
#     engine_version = "5.6.17"
#     instance_class = "db.t1.micro"
    
#     username = var.username
#     password = var.password
#     skip_final_snapshot = true
  
# }

resource "mysql_database" "app" {
    name = var.db_name
  
}


resource "aws_db_subnet_group" "this" {
    name = "${var.db_name}-subnet-group"
    subnet_ids = var.subnet_ids

    tags = {
      Name = "${var.db_name}-subnet-group"
    }
  
}