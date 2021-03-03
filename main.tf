provider "aws" {
	region = "us-east-2"
}

resource "aws_key_pair" "k8s-key" {
	key_name	= "k8s-key"
	public_key	= "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDkBflXAGBAB42ZsvluHe8fElKUxXdU5ie5vZjxSBULltBBiN7cHMRziInKRAVWGqjtLbQf7V10I9RNVd/9NQNNQYS1Buk0P8mSDx0udXwXmNA2s9YclpOBIqqEBLYG9wzCvp7iHiEtjHV6zWw2WWLxO3HOsYuwarJzIsZRbdRHc668GogFJHtXhEzrynw4PRg4O8MTxJxPNN+lnxHdxZli/5MdE+h8tvY3h87Xjfye9Y1M1cfUR8WwWcrCFwz2m3Bc0bt+WjwytuAF1IjT6PML8994DSqpKuS+FsCsZ1I0Yytnwkyfd+GoTcker38M7YLd7LVUU0EArGNbuK4YdtBB garrett@Ubuntu-teste"
}

resource "aws_security_group" "k8s-sg" {

	ingress {
	  from_port	= 0
	  to_port	= 0
	  protocol	= "-1"
	  self	= true
	  }
	  
	ingress {
	  from_port	= 22
	  to_port	= 22
	  protocol	= "tcp"
	  cidr_blocks	= ["0.0.0.0/0"]
	  }
	  
	egress {
		cidr_blocks	= ["0.0.0.0/0"]
		from_port	= 0
		to_port		= 0
		protocol	= "-1"
		}
	
  }	
  resource "aws_instance" "kubernetes-worker" {
    ami		= "ami-02aa7f3de34db391a"
	instance_type	= "t3.medium"
	key_name	= "k8s-key"
	count	= 2
	tags	= {
	  name	= "k8s"
	  type	= "worker"
	}
	security_groups	= ["${aws_security_group.k8s-sg.name}"]
  }
  resource "aws_instance" "kubernetes-master" {
	ami		= "ami-02aa7f3de34db391a"
	instance_type	= "t3.medium"
	key_name	= "k8s-key"
	count	= 1
	tags	= {
	  name	= "k8s"
	  type	= "master"
	}
	security_groups	= ["${aws_security_group.k8s-sg.name}"]
  }
