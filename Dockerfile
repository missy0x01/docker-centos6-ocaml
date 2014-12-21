FROM centos:centos6
MAINTAINER missy0x01 missy0x01

RUN yum -y update
RUN yum install -y openssh-server
RUN bash -c 'echo "root:root" | chpasswd'
RUN sed -i '/pam_loginuid\.so/s/required/optional/' /etc/pam.d/sshd
RUN service sshd start
RUN service sshd stop

RUN yum -y install git mercurial
RUN yum -y groupinstall "Development Tools"
RUN curl -o /etc/yum.repos.d/home:ocaml.repo -OL http://download.opensuse.org/repositories/home:ocaml/CentOS_6/home:ocaml.repo
RUN yum install -y opam
RUN opam init --comp=4.01.0

RUN yum -y install zsh which
RUN chsh -s /bin/zsh

# .zshrc, .emacs

RUN yum install -y emacs
RUN git clone https://github.com/ocaml/tuareg
WORKDIR /root/tuareg
RUN make
RUN make install
WORKDIR /root/
RUN rm -rf tuareg

CMD /usr/sbin/sshd -D
EXPOSE 22


