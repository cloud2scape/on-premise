#aws rpovider
provider "aws" {
    region = "ap-northeast-2"
  
}

module "vpc" {
    source = "./modules/vpc"
    nat_interface_network_interface_id = module.ec2.nat_interface_network_interface_id
  
}

module "subnet" {
    source = "./modules/subnet"
    vpc_id = module.vpc.vpc_id
    route_table_id = module.vpc.route_table_id
    route_table_id1 = module.vpc.route_table_id1
  
}

module "security-group" {
    source = "./modules/security-group"
    vpc_id = module.vpc.vpc_id
  
}

module "key_pair" {
    source = "./modules/key-pair"
  
}

module "ec2" {
    source = "./modules/ec2"
    security_group_id = module.security-group.security_group_id
    public_subnet_ids = module.subnet.public_subnet_ids
    private_subnet_ids = module.subnet.private_subnet_ids
    key_name = module.key_pair.key_name

  
}

module "s3" {
    source = "./modules/s3"
    bucket_name = "my-unique-bucket-soomin-gim"
    acl = "private"
  
}

module "rds" {
    source = "./modules/rds"
    db_name = "mydatabase"
    username="postgres"
    password="test1234"
    vpc_security_gorup_ids = [module.security-group.security_group_id]
    subnet_ids = module.subnet.private_subnet_ids
  
}

module "alb" {
    source = "./modules/alb"
    vpc_id = module.vpc.vpc_id
    subnet_ids = module.subnet.public_subnet_ids
    security_group_ids = [module.security-group.security_group_id]
    target_instance_ids = [module.ec2.web1_id, module.ec2.web2_id]
  
}