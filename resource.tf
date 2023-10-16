resource "aws_instance" "example" {
  ami           = "ami-08e5424edfe926b43"
  subnet_id     = "subnet-03636f4ef3d8a6be2"
  instance_type = "t2.micro"
  key_name      = "sandeep"

  provisioner "local-exec" {
    command = "echo ${aws_instance.example.private_ip} >> private.txt"
  }


  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install -f",
      "sudo apt clean",
      "sudo apt update",
      "sudo apt install apache2 -y ",
      "sudo service apache2 enable",
      "sudo service apache2 start"
    ]
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("./sandeep.pem")
      host        = self.public_ip

    }
  }

}

