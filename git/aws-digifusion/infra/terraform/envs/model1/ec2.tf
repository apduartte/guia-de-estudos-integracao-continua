############################################
# IAM Role para SSM
############################################

resource "aws_iam_role" "ssm_role" {
  name = "ec2-ssm-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ssm_attach" {
  role       = aws_iam_role.ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ssm_profile" {
  name = "ec2-ssm-profile"
  role = aws_iam_role.ssm_role.name
}

############################################
# EC2 Instance
############################################

resource "aws_instance" "poc_ec2" {
  ami           = "ami-0c02fb55956c7d316" # Amazon Linux 2
  instance_type = "t2.micro"

  subnet_id              = aws_subnet.poc_subnet.id
  vpc_security_group_ids = [aws_security_group.poc_sg.id]

  iam_instance_profile = aws_iam_instance_profile.ssm_profile.name

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras install docker -y
              systemctl start docker
              usermod -a -G docker ec2-user
              docker run -d -p 5678:5678 n8nio/n8n
              EOF

  tags = {
    Name = "poc-n8n-ec2"
  }
}
