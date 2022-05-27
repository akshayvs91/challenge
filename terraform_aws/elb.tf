resource "aws_lb" "internet-elb" {
  name               = "internet-elb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.elb-sg.id]
  subnets            = [aws_subnet.public-subnet-1.id, aws_subnet.public-subnet-2.id]
}

resource "aws_lb_target_group" "internet-elb" {
  name     = "internet-elb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.challenge-vpc.id
}

resource "aws_lb_target_group_attachment" "internet-elb" {
  target_group_arn = aws_lb_target_group.internet-elb.arn
  target_id        = aws_instance.server-1.id
  port             = 80

  depends_on = [
    aws_instance.server-1,
  ]
}

resource "aws_lb_listener" "internet-elb" {
  load_balancer_arn = aws_lb.internet-elb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.internet-elb.arn
  }
}
