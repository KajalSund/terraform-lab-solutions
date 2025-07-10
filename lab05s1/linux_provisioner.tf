resource "null_resource" "linux_hostnames" {
  count = var.nb_count
  depends_on = [azurerm_linux_virtual_machine.linux_vm]

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      host        = azurerm_public_ip.linux_pip[count.index].ip_address
      user        = var.admin_username
      private_key = file("~/.ssh/id_rsa_azure")
    }

    inline = [
      "echo '*** Hostname for ${azurerm_linux_virtual_machine.linux_vm[count.index].name} ***'",
      "hostname"
    ]
  }
}

