FROM debian:latest

RUN apt-get update
RUN apt-get install -y --no-install-recommends \
      curl \
      ca-certificates \
      git \
      sudo
RUN echo "owner ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/owner

RUN useradd -ms /bin/bash owner

USER owner
WORKDIR /home/owner

RUN bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

COPY . /home/owner/.dotfiles
