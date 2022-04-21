module "network_module" {
  source			= "./modules/network"
 	access_key		= "${var.access_key}"
	secret_key		= "${var.secret_key}"
	region			= "${var.region}"
	environment_tag = "${var.environment_tag}"
}

module "security_group_module" {
  source			= "./modules/security_group"
 	access_key		= "${var.access_key}"
	secret_key		= "${var.secret_key}"
	region			= "${var.region}"
	vpc_id			= "${module.network_module.vpc_id}"
	environment_tag = "${var.environment_tag}"
}

module "instance_module" {
	source 				= "./modules/instance"
	access_key 			= "${var.access_key}"
 	secret_key 			= "${var.secret_key}"
 	region     			= "${var.region}"
	availability_zone = "${var.availability_zone}"
 	vpc_id 				= "${module.network_module.vpc_id}"
	devops_subnet	= "${module.network_module.devops_subnet[0]}"
	devops_gw = "${module.network_module.devops_gw}"
	key_name		= "${var.key_name}"
	devops_security_group 	= ["${module.security_group_module.jenkins_sg}"]
}
