data "template_file" "client" {
  template = file("./user_data/run_on_client.sh")
}data "template_cloudinit_config" "config" {
  gzip          = false
  base64_encode = false  #first part of local config file
  part {
    content_type = "text/x-shellscript"
    content      = <<-EOF
    #!/bin/bash
    echo 'instance_target_host="${aws_instance.example-server-ec2.private_ip}"' > /opt/server_ip
    EOF
  }  #second part
  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.client.rendered
  }
}

    Create user data shell script

