# Create the Auto Scaling launch config
data "template_file" "init" {
  template = file("scripts/deploy-react-application.sh.tpl")

  vars = {
    UNIQUE_ANIMAL_IDENTIFIER = "${var.UNIQUE_ANIMAL_IDENTIFIER}"
  }
}

resource "aws_launch_configuration" "lc" {
  name_prefix                 = "playground-"
  image_id                    = data.aws_ami.amazon-linux-2.id
  instance_type               = "t2.small"
  security_groups             = [var.security_group_id]
  user_data                   = data.template_file.init.rendered
  key_name                    = "playground-november-key"
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.deploy_profile.name

  lifecycle {
    create_before_destroy = true
  }
}

# Create the Auto Scaling group
resource "aws_autoscaling_group" "asg" {
  name                 = "playground-${aws_launch_configuration.lc.name}-dpg-november"
  max_size             = 3
  min_size             = 1
  desired_capacity     = 1
  health_check_type    = "EC2"
  launch_configuration = aws_launch_configuration.lc.name
  vpc_zone_identifier  = [var.subnet_id]
  load_balancers       = [var.elb_id]

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = lower("playground-${var.UNIQUE_ANIMAL_IDENTIFIER}-dpg-november")
    propagate_at_launch = true
  }

  timeouts {
    delete = "15m"
  }
}