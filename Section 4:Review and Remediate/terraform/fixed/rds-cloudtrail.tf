terraform {
  required_version = ">= 1.6.0"
  required_providers { aws = { source = "hashicorp/aws", version = "~> 5.0" } }
}
provider "aws" { region = "ap-south-1" }
variable "db_password" { type = string, sensitive = true }

resource "aws_db_instance" "accounts" {
  identifier = "accounts-prod"
  engine = "postgres"
  instance_class = "db.r6g.large"
  username = "postgres"
  password = var.db_password
  publicly_accessible = false
  storage_encrypted = true
  backup_retention_period = 30
  skip_final_snapshot = false
  deletion_protection = true
}

resource "aws_security_group_rule" "db_ingress" {
  type = "ingress"
  from_port = 5432
  to_port = 5432
  protocol = "tcp"
  cidr_blocks = ["10.20.0.0/16"]
  security_group_id = aws_security_group.db.id
}

resource "aws_cloudtrail" "org" {
  name = "org-trail"
  s3_bucket_name = aws_s3_bucket.trail.id
  is_multi_region_trail = true
  enable_log_file_validation = true
  include_global_service_events = true
  is_organization_trail = true
}
resource "aws_s3_bucket" "trail" { bucket = "accounts-org-cloudtrail-placeholder" }
