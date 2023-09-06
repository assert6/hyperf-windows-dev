FROM python:3.11.3-slim

RUN apt-get update

# sftp
RUN apt-get install openssh-server -y \
    && apt-get install openssh-sftp-server -y \
    && ssh-keygen -t rsa -N "" -y -f /etc/ssh/ssh_host_rsa_key \
    && ssh-keygen -t ecdsa -N "" -y -f /etc/ssh/ssh_host_ecdsa_key \
    && ssh-keygen -t ed25519 -N "" -y -f /etc/ssh/ssh_host_ed25519_key

RUN mkdir /root/.ssh \
    && echo "PermitRootLogin yes" >> /etc/ssh/sshd_config \
    && echo "PermitEmptyPasswords yes" >> /etc/ssh/sshd_config \
    && passwd -d root \
    && mkdir /run/sshd

RUN pip install --upgrade pip

WORKDIR /home

EXPOSE 5000

CMD ["sh", "-c", "/usr/sbin/sshd && /bin/bash"]
