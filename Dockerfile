FROM ubuntu:18.04
RUN apt-get update && \
apt-get install ansible wget unzip python3-pip -y && \
pip3 install boto && \
wget https://releases.hashicorp.com/terraform/0.14.7/terraform_0.14.7_linux_amd64.zip \
unzip terraform_0.14.7_linux_amd64.zip -d /usr/bin \
