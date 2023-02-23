data "aws_availability_zones" "available"{}

resource "random_id" "random" {
    byte_length = 2
}

resource "aws_vpc" "mtc_vpc" {//this name is for terraform, AWS doesnot refer
    cidr_block = "10.123.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support = true
    
    tags = {
        Name = "mtc_vpc-${random_id.random.dec}"//name for AWS
    }
    lifecycle {
        create_before_destroy = true
    }
}//upon running terraform apply this will create a aws_vpc for us

resource "aws_internet_gateway" "mtc_internet_gateway" {
    vpc_id = aws_vpc.mtc_vpc.id //uses the vpc from above
    
    tags = {
        Name = "mtc_igw-${random_id.random.dec}"
    }
}

resource "aws_route_table" "mtc_public_rt" {
    vpc_id = aws_vpc.mtc_vpc.id
    
    tags = {
        Name = "mtc-public"
    }
}

resource "aws_route" "default_aws_route" {
    route_table_id = aws_route_table.mtc_public_rt.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mtc_internet_gateway.id
}

resource "aws_default_route_table" "mtc_private_rt"{
    default_route_table_id = aws_vpc.mtc_vpc.default_route_table_id
    
    tags = {
        Name = "mtc_private"
    }
}