# Terraform Providers

Terraform providers translate `.tf` code into the required target provider code.

## Types
- **Official**: AWS, Azure, GCP
- **3rd Party**: Various providers
- **Community**: Open-source versions

Note: Terraform is not only for cloud; it can be used for Datadog, Docker, Kubernetes, etc.

## Versioning
- **Terraform Version**: Specifies the required Terraform version.
- **Provider Version**: Specified under the cloud provider name.
- If not mentioned, it uses the latest version.

Why versioning? Terraform and provider versions may not be compatible, so locking versions is important.

## Operators
- `=`, `!=`, `<`, `>`
- `~>`: Controls the version of the last decimal point (e.g., `1.1` or `1.2.1`). Allows updates within the specified range but not beyond (e.g., up to `2.0` or `1.3` excluding them).



Local VS Remote VS File:
Terraform provisioners, 

this performs a task => Executing a script , running a command etc

Local exec => scripts run locally , something local cli , terraform host 
remote exec => execute commands in a remote machine , done via ssh 
File => copy files from remote 

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  # Backend configuration example is placed in backend.tf (commented out by default)
}

# EC2 instance used for provisioner demos.
# Each provisioner block is included below but wrapped in block comments (/* ... */).
# For the demo, uncomment one provisioner block at a time, then `terraform apply`.

resource "aws_instance" "demo" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.ssh.id]

  tags = {
    Name = "terraform-provisioner-demo"
  }

  connection {
    type        = "ssh"
    user        = var.ssh_user
    private_key = file(var.private_key_path)
    host        = self.public_ip
  }

  /*
  ------------------------------------------------------------------
  Provisioner 1: local-exec
  - Runs on the machine where you run Terraform (your laptop/CI agent).
  - Useful for local tasks, logging, calling local scripts, etc.
  - To demo: uncomment this block, then run `terraform apply`.
  ------------------------------------------------------------------
  */

  # provisioner "local-exec" {
  #   command = "echo 'Local-exec: created instance ${self.id} with IP ${self.public_ip}'"
  # }


  /*
  ------------------------------------------------------------------
  Provisioner 2: remote-exec
  - Runs commands on the remote instance over SSH.
  - Requires SSH access (security group + key pair + reachable IP).
  - To demo: uncomment this block, ensure `var.private_key_path` is correct, then run `terraform apply`.
  ------------------------------------------------------------------
  */
  
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "echo 'Hello from remote-exec' | sudo tee /tmp/remote_exec.txt",
    ]
  }
  

  /*
  ------------------------------------------------------------------
  Provisioner 3: file + remote-exec
  - Copies a script (scripts/welcome.sh) to the instance, then executes it.
  - Good pattern for more complex bootstrapping when script files are preferred.
  - To demo: uncomment both the file provisioner and the remote-exec block below.
  ------------------------------------------------------------------
  */
  /*
  provisioner "file" {
    source      = "${path.module}/scripts/welcome.sh"
    destination = "/tmp/welcome.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/welcome.sh",
      "sudo /tmp/welcome.sh"
    ]
  }
  */
}