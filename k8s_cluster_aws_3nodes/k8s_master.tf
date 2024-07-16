# Define your Kubernetes master node(s)
resource "aws_instance" "master_kubernetes" {
  count         = 1  # Assuming one master node
  ami           = "ami-0a0e5d9c7acc336f1"  # Replace with your desired AMI ID
  instance_type = "t2.medium"  # Replace with your desired instance type
  # Other instance configuration properties like subnet_id, key_name, etc.
  key_name = "trr"
  vpc_security_group_ids = [aws_security_group.kubernetes_master_sg.id]

  tags = {
    Name = "Test-kubernetes-master"
  }
}

# Define security group for Kubernetes master node with dynamic ingress rules
resource "aws_security_group" "kubernetes_master_sg" {
  name        = "kubernetes-master-sg"
  description = "Security group for Kubernetes master node"

  dynamic "ingress" {
    for_each = {
      kube_api       = { from_port = 6443, to_port = 6443, protocol = "tcp", description = "Kubernetes API server" },
      etcd_client    = { from_port = 2379, to_port = 2380, protocol = "tcp", description = "etcd server client API" },
      kubelet_api    = { from_port = 10250, to_port = 10250, protocol = "tcp", description = "Kubelet API" },
      kube_scheduler = { from_port = 10259, to_port = 10259, protocol = "tcp", description = "kube-scheduler" },
      kube_controller= { from_port = 10257, to_port = 10257, protocol = "tcp", description = "kube-controller-manager" },
    }

    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ["0.0.0.0/0"]  # Allow traffic from any IP (adjust as needed)
      description = ingress.value.description
    }
  }

  # Egress rule allowing all traffic out (example)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
