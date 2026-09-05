package main

deny contains "T4: RDS must not be publicly accessible" if { some _, r in input.resource.aws_db_instance; r.publicly_accessible == true }
deny contains "T4: RDS storage must be encrypted" if { some _, r in input.resource.aws_db_instance; r.storage_encrypted == false }
deny contains "T4: RDS must retain backups" if { some _, r in input.resource.aws_db_instance; r.backup_retention_period == 0 }
deny contains "T4: DB ingress must not allow the internet" if { some _, r in input.resource.aws_security_group_rule; r.type == "ingress"; r.from_port <= 5432; r.to_port >= 5432; r.cidr_blocks[_] == "0.0.0.0/0" }
deny contains "T5: CloudTrail must be multi-region" if { some _, r in input.resource.aws_cloudtrail; r.is_multi_region_trail == false }
deny contains "T5: CloudTrail must validate log files" if { some _, r in input.resource.aws_cloudtrail; r.enable_log_file_validation == false }
deny contains "T5: CloudTrail must include global service events" if { some _, r in input.resource.aws_cloudtrail; r.include_global_service_events == false }
