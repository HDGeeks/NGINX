resource "random_pet" "ssh_key_name" {
  prefix    = "ssh"
  separator = ""
}

resource "azapi_resource" "ssh_public_key" {
  type      = "Microsoft.Compute/sshPublicKeys@2022-11-01"
  name      = random_pet.ssh_key_name.id
  location  = var.resource_group_location
  parent_id = var.resource_group_id
}

resource "azapi_resource_action" "ssh_public_key_gen" {
  type        = "Microsoft.Compute/sshPublicKeys@2022-11-01"
  resource_id = azapi_resource.ssh_public_key.id
  action      = "generateKeyPair"
  method      = "POST"

  response_export_values = ["publicKey", "privateKey"]
}

resource "null_resource" "ssh_key_setup_for_ipv4" {
 
  provisioner "local-exec" {
    command = <<EOT
      # Create the PEM file with the private key
      echo "${azapi_resource_action.ssh_public_key_gen.output.privateKey}" > ~/.ssh/${random_pet.ssh_key_name.id}.pem
      
      # Set file permissions to 400 (read-only for owner)
      chmod 400 ~/.ssh/${random_pet.ssh_key_name.id}.pem

      # Define the SSH config file path
      ssh_config_file=~/.ssh/config

      # Check if the Host entry exists in the SSH config, otherwise append it
      if ! grep -q "${random_pet.ssh_key_name.id}" $ssh_config_file; then
        echo "Host ${var.vm_public_ip}" >> $ssh_config_file
        echo "    Hostname ${var.vm_public_ip}" >> $ssh_config_file
        echo "    Port 22" >> $ssh_config_file
        echo "    User ${var.username}" >> $ssh_config_file
        echo "    IdentityFile ~/.ssh/${random_pet.ssh_key_name.id}.pem" >> $ssh_config_file
      fi
    EOT
  }
}

resource "null_resource" "ssh_key_setup_for_dns_label" {
 
  provisioner "local-exec" {
    command = <<EOT
      # Create the PEM file with the private key
      echo "${azapi_resource_action.ssh_public_key_gen.output.privateKey}" > ~/.ssh/${random_pet.ssh_key_name.id}.pem
      
      # Set file permissions to 400 (read-only for owner)
      chmod 400 ~/.ssh/${random_pet.ssh_key_name.id}.pem

      # Define the SSH config file path
      ssh_config_file=~/.ssh/config

      # Check if the Host entry exists in the SSH config, otherwise append it
      if ! grep -q "${random_pet.ssh_key_name.id}" $ssh_config_file; then
        echo "Host ${var.domain_name_label}" >> $ssh_config_file
        echo "    Hostname ${var.domain_name_label}" >> $ssh_config_file
        echo "    Port 22" >> $ssh_config_file
        echo "    User ${var.username}" >> $ssh_config_file
        echo "    IdentityFile ~/.ssh/${random_pet.ssh_key_name.id}.pem" >> $ssh_config_file
      fi
    EOT
  }
}



# Create a dynamic Ansible inventory
resource "null_resource" "ansible_inventory" {
  provisioner "local-exec" {
    command = <<EOT
      cat <<EOF > ~/ansible/hosts.yaml
---
all:
  children:
    ubuntu_containers:
      hosts:
        ubuntu-container-1:
          ansible_host: localhost
          ansible_port: "2222"
          ansible_user: ansible_user
          ansible_ssh_private_key_file: ~/.ssh/id_rsa
          ansible_sudo_password: "password" # Add your sudo password here
          ansible_become_password: "password"

    azure:
      hosts:
        ${var.domain_name_label}:
          ansible_user: "azureadmin"
EOF
    EOT
  }

  depends_on = [null_resource.ssh_key_setup_for_dns_label]
}



