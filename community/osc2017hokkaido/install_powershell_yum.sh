# Bash(yum)
curl https://packages.microsoft.com/config/rhel/7/prod.repo \
    | sudo tee /etc/yum.repos.d/microsoft.repo
sudo yum install -y powershell
