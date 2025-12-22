# Userdata file for installation

#!/usr/bin/env bash
set -euo pipefail

export DEBIAN_FRONTEND=noninteractive

# Basic packages
apt-get update -y
apt-get install -y \
  ca-certificates curl gnupg lsb-release unzip git apt-transport-https software-properties-common

# -------------------------
# Docker
# -------------------------
apt-get install -y docker.io
systemctl enable docker
systemctl start docker

# Allow ubuntu user to run docker without sudo
usermod -aG docker ubuntu || true
chmod 666 /var/run/docker.sock || true

# -------------------------
# Java 17 (Jenkins requirement)
# -------------------------
apt-get install -y fontconfig openjdk-17-jre

# -------------------------
# Jenkins
# -------------------------
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" > /etc/apt/sources.list.d/jenkins.list

apt-get update -y
apt-get install -y jenkins

systemctl enable jenkins
systemctl start jenkins

# -------------------------
# Trivy
# -------------------------
curl -fsSL https://aquasecurity.github.io/trivy-repo/deb/public.key | gpg --dearmor -o /usr/share/keyrings/trivy.gpg
echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" > /etc/apt/sources.list.d/trivy.list

apt-get update -y
apt-get install -y trivy

# initial Jenkins admin password
echo "Jenkins initial admin password:"
cat /var/lib/jenkins/secrets/initialAdminPassword || true
