resource "aws_autoscaling_group" "node" {
  count = var.asg_per_subnet ? length(var.vpc_subnets) : 1

  name                = "eks-${var.cluster_name}-nodes-${var.nodegroup_name}-${count.index}"
  desired_capacity    = var.asg_desired_capacity
  min_size            = var.asg_min_size
  max_size            = var.asg_max_size
  vpc_zone_identifier = var.asg_per_subnet ? [element(var.vpc_subnets, count.index)] : var.vpc_subnets

  suspended_processes = var.suspended_processes
  enabled_metrics     = var.enabled_metrics

  mixed_instances_policy {
    instances_distribution {
      on_demand_allocation_strategy            = var.on_demand_allocation_strategy
      on_demand_base_capacity                  = var.on_demand_base_capacity
      on_demand_percentage_above_base_capacity = var.on_demand_percentage_above_base_capacity
      spot_allocation_strategy                 = var.spot_allocation_strategy
      spot_instance_pools                      = var.spot_instance_pools
      spot_max_price                           = var.spot_max_price
    }

    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.node.id
        version            = "$Latest"
      }

      dynamic "override" {
        for_each = var.instance_types

        content {
          instance_type = override.value
        }
      }
    }
  }

  lifecycle {
    ignore_changes = [desired_capacity]
  }

  # Workaround for https://github.com/hashicorp/terraform-provider-aws/issues/14085
  dynamic "tag" {
    for_each = local.tags
    content {
      key                 = tag.value.key
      value               = tag.value.value
      propagate_at_launch = tag.value.propagate_at_launch
    }
  }
}

resource "aws_launch_template" "node" {
  name_prefix = "eks-${var.cluster_name}-nodes-${var.nodegroup_name}"

  image_id      = local.ami_id
  instance_type = var.instance_types[0]
  user_data     = base64encode(data.template_file.launch_template_userdata.rendered)

  vpc_security_group_ids = [var.control_plane_security_group]

  iam_instance_profile {
    name = aws_iam_instance_profile.nodes_launch_template.name
  }

  block_device_mappings {
    device_name = data.aws_ami.eks_worker.root_device_name

    ebs {
      volume_size           = var.root_volume_size
      volume_type           = "gp2"
      delete_on_termination = true
    }
  }

  monitoring {
    enabled = var.detailed_monitoring
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_iam_instance_profile" "nodes_launch_template" {
  role = var.iam_role_name
}

locals {
  transformed_tags = [for k, v in var.tags :
    {
      key                 = k
      value               = v
      propagate_at_launch = "true"
    }
  ]

  tags = concat([
    {
      "key"                 = "Name"
      "value"               = "eks-${var.cluster_name}-nodes-${var.nodegroup_name}"
      "propagate_at_launch" = "true"
    },
    {
      "key"                 = "kubernetes.io/cluster/${var.cluster_name}"
      "value"               = "owned"
      "propagate_at_launch" = "true"
    },
    {
      "key"                 = "k8s.io/cluster-autoscaler/${var.autoscaling_enabled == true ? "enabled" : "disabled"}"
      "value"               = "true"
      "propagate_at_launch" = "false"
    },
    {
      "key"                 = "k8s.io/cluster-autoscaler/${var.cluster_name}"
      "value"               = "owned"
      "propagate_at_launch" = "true"
    }
    ],
    local.transformed_tags
  )
}
