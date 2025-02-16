resource "aws_db_subnet_group" "rds" {
  name       = "rds-subnet-group"
  subnet_ids = aws_subnet.private[*].id
}

resource "aws_db_instance" "main" {
  identifier          = "main-rds"
  allocated_storage   = 20
  engine              = "mysql"
  engine_version      = "8.0"
  instance_class      = "db.t3.micro"
  username            = "dbadmin" # Change from "admin"
  password            = "securepassword123"
  publicly_accessible = false
  skip_final_snapshot = true
}
