FROM hyperf/hyperf:latest

# watch
RUN git clone https://github.com/assert6/hyperf-watch.git \
    && mv hyperf-watch/hyperf-watch /usr/bin/ \
    && chmod +x  /usr/bin/hyperf-watch \
    && rm -rf hyperf-watch

# sftp
RUN apk add openssh-server \
    && apk add openssh-sftp-server \
    && ssh-keygen -t rsa -N "" -f /etc/ssh/ssh_host_rsa_key \
    && ssh-keygen -t ecdsa -N "" -f /etc/ssh/ssh_host_ecdsa_key \
    && ssh-keygen -t ed25519 -N "" -f /etc/ssh/ssh_host_ed25519_key

RUN mkdir /root/.ssh \
    && echo "你的公钥" > /root/.ssh/authorized_keys \
    && echo "PermitRootLogin yes" >> /etc/ssh/sshd_config \
    && echo "PermitEmptyPasswords yes" >> /etc/ssh/sshd_config \
    && passwd -d root

WORKDIR /home

EXPOSE 22
EXPOSE 9501

CMD ["sh", "-c", "/usr/sbin/sshd && hyperf-watch -c --dir /home"]