FROM postgres:13

# RUN echo 'deb http://mirrors.163.com/debian/ buster main non-free contrib\ndeb http://mirrors.163.com/debian/ buster-updates main non-free contrib\ndeb http://mirrors.163.com/debian/ buster-backports main non-free contrib\ndeb-src http://mirrors.163.com/debian/ buster main non-free contrib\ndeb-src http://mirrors.163.com/debian/ buster-updates main non-free contrib\ndeb-src http://mirrors.163.com/debian/ buster-backports main non-free contrib\ndeb http://mirrors.163.com/debian-security/ buster/updates main non-free contrib\ndeb-src http://mirrors.163.com/debian-security/ buster/updates main non-free contrib' > /etc/apt/sources.list

RUN export DEBIAN_FRONTEND=noninteractive &&\
    apt update &&\
    apt install -y --no-install-recommends \
    gcc \
    make \
    ca-certificates \
    git \
    postgresql-server-dev-13 && \
    apt autoremove -y && \
    apt clean -y && \
    rm -rf /var/lib/apt/lists/*

RUN git clone --depth 1 https://github.com/zejn/pg-colors


RUN cd pg-colors && sed -i 's/--load-language=plpgsql//' Makefile &&\
    make && make install
