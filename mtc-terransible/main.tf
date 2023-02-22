resource "aws_vpc" "mtc_vpc" {//this name is for terraform, AWS doesnot refer
    cidr_block = "10.123.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support = true
    
    tags = {
        Name = "mtc_vpc"//name for AWS
    }
}//upon running terraform apply this will create a aws_vpc for us