resource "null_resource" "linux_provision" {
  count      = var.nb_count
  depends_on = [azurerm_linux_virtual_machine.linux_vm]

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      host        = azurerm_public_ip.linux_pip[count.index].ip_address
      user        = var.admin_username
      private_key = file(var.admin_ssh_private_key)
    }

    inline = [
      "echo '*** Hostname for ${azurerm_linux_virtual_machine.linux_vm[count.index].name} ***'",
      "hostname",
      "sudo dnf update -y",
      "sudo dnf install -y nginx",
      "sudo systemctl enable nginx",
      "sudo systemctl start nginx"
    ]
  }
}
