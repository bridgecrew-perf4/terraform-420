data "aws_ip_ranges" "us_west_ip_range" {
  regions  = ["us-west-1", "us-west-2"]
  services = ["ec2"]
}

resource "aws_security_group" "sg_custom_us_west" {
  name = "sg_custom_us_west"

  ingress {
    from_port   = "443"
    to_port     = "443"
    protocol    = "tcp"
    cidr_blocks = slice(data.aws_ip_ranges.us_west_ip_range.cidr_blocks, 0, 20)
  }

  tags = {
    CreateDate = data.aws_ip_ranges.us_west_ip_range.create_date
    SyncToken  = data.aws_ip_ranges.us_west_ip_range.sync_token
  }
}
