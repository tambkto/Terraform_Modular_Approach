    module "vpc_virginia" {
    source = "./modules/vpc"
    vpc_cidr = var.virginia_vpc_cidr
    public_subnet_cidr = var.VirVpc_PubSub_Cidr
    private_subnet_cidr = var.VirVpc_PrivSub_Cidr
    region_name = "virginia"
    cidr_allowing_all = var.cidr_allowing_all
    providers = {
        aws = aws.virginia
    }
    }
