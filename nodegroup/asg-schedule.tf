# Stop all instances each weekday at 6pm 
resource "aws_autoscaling_schedule" "node_shutdown" {
  count                  = var.create_schedule ? length(var.vpc_subnets) : 0
  scheduled_action_name  = "eks-${var.cluster_name}-nodes-shutdown-${var.nodegroup_name}-${count.index}"
  min_size               = 0
  max_size               = 0
  desired_capacity       = 0
  recurrence             = var.scheduled_shutdown
  autoscaling_group_name = aws_autoscaling_group.node[count.index].name
}

# Startup 1 instance each weekday at 9am 
resource "aws_autoscaling_schedule" "node_startup" {
  count                  = var.create_schedule ? length(var.vpc_subnets) : 0
  scheduled_action_name  = "eks-${var.cluster_name}-nodes-startup-${var.nodegroup_name}-${count.index}"
  min_size               = var.asg_min_size
  max_size               = var.asg_max_size
  desired_capacity       = var.asg_desired_capacity
  recurrence             = var.scheduled_startup
  autoscaling_group_name = aws_autoscaling_group.node[count.index].name
}