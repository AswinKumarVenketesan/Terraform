resource "aws_launch_template" "eks-kube-nodes" {
  name_prefix            = "eks-kube-nodes"
  description            = "eks-kube-nodes-Launch-Template"
  update_default_version = true

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      delete_on_termination = true
      encrypted             = true
      volume_size           = 50
      volume_type           = "gp3"
    }
  }

  network_interfaces {
    associate_public_ip_address = false
    delete_on_termination       = true
    security_groups             = [module.eks.worker_security_group_id]
  }

  
  lifecycle {
    create_before_destroy = true
  }
}
