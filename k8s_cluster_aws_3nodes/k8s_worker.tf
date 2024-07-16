# Define your Kubernetes worker node(s)
resource "aws_instance" "worker_nodes" {
  count         = 2  # Number of worker nodes
  ami           = "ami-0a0e5d9c7acc336f1"  # Replace with your desired AMI ID
  instance_type = "t2.micro"  # Replace with your desired instance type
  # Other instance configuration properties like subnet_id, key_name, etc.
  key_name = "trr"
  vpc_security_group_ids = [aws_security_group.kubernetes_worker_sg.id]

  tags = {
    Name = "test-kubernetes-worker-${count.index}"
  }
}

# Define security group for Kubernetes worker nodes with dynamic ingress rules
resource "aws_security_group" "kubernetes_worker_sg" {
  name        = "kubernetes-worker-sg"
  description = "Security group for Kubernetes worker nodes"

  dynamic "ingress" {
    for_each = {
      kubelet_api    = { from_port = 10250, to_port = 10250, protocol = "tcp", description = "Kubelet API" },
      kube_proxy     = { from_port = 10256, to_port = 10256, protocol = "tcp", description = "kube-proxy metrics" },
      node_exporter  = { from_port = 9100, to_port = 9100, protocol = "tcp", description = "node-exporter metrics" },
      flannel        = { from_port = 8285, to_port = 8285, protocol = "udp", description = "flannel network overlay" },
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
