FROM elixir:1.17.2-otp-26 as exec
RUN apt update -y && apt install -y build-essential inotify-tools npm git openssh-server
RUN mix do local.hex --force, local.rebar --force, archive.install --force hex phx_new
RUN mkdir /var/run/sshd; \
  echo 'root:hoge' | chpasswd; \ 
  echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config; \
  echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config

CMD ["/usr/sbin/sshd", "-D"]