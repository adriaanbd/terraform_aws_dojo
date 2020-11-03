module "network" {
  source    = "./network"
  namespace = var.namespace
}

module "security" {
  source    = "./security"
  namespace = var.namespace
  vpc_id    = module.network.vpc_id
}

module "compute" {
  source                = "./compute"
  namespace             = var.namespace
  key_pair_name         = var.key_pair_name
  pub_a_id              = module.network.pub_a_id
  pub_b_id              = module.network.pub_b_id
  pub_c_id              = module.network.pub_c_id
  priv_a_id             = module.network.priv_a_id
  priv_b_id             = module.network.priv_b_id
  priv_c_id             = module.network.priv_c_id
  bastion_sg_a          = module.security.bastion_sg_a
  bastion_sg_b          = module.security.bastion_sg_a
  bastion_sg_c          = module.security.bastion_sg_a
  app_sg_a_id           = module.security.app_sg_a
  app_sg_b_id           = module.security.app_sg_b
  app_sg_c_id           = module.security.app_sg_c
  ecs_profile_arn       = module.security.ecs_instance_profile_arn
  # ecs_service_role_name = module.security.ecs_service_role_name
}
