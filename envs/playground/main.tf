# Playground environment — same module wiring as envs/dev, local state.

module "vpc" {
  source = "../../modules/vpc"

  name                = var.name
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
  availability_zones  = var.availability_zones
  tags                = var.tags
}

module "security" {
  source = "../../modules/security"

  name          = var.name
  vpc_id        = module.vpc.vpc_id
  allowed_cidrs = var.allowed_cidrs
  tags          = var.tags
}
