# Security Group for Lambda/EC2 (App Logic)
resource "aws_security_group" "app" {
  name        = "app-sg"
  description = "Allow outbound to RDS and ElastiCache"
  vpc_id      = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Security Group for RDS
resource "aws_security_group" "rds" {
  name        = "rds-sg"
  description = "Allow inbound from App Security Group"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.app.id]
  }
}

# Security Group for ElastiCache (Redis/Memcached)
resource "aws_security_group" "cache" {
  name        = "cache-sg"
  description = "Allow inbound from App Security Group"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port       = 6379 # Redis
    to_port         = 6379
    protocol        = "tcp"
    security_groups = [aws_security_group.app.id]
  }

  ingress {
    from_port       = 11211 # Memcached
    to_port         = 11211
    protocol        = "tcp"
    security_groups = [aws_security_group.app.id]
  }
}