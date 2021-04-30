FROM ubuntu:21.04

LABEL maintainer="Vi P <vignesh@admin.com>"

ARG TIMEZONE='Pacific/Auckland'
ARG DEBIAN_FRONTEND=noninteractive

RUN echo $TIMEZONE > /etc/timezone && \
  apt-get update && apt-get install -y tzdata && \
  rm /etc/localtime && \
  ln -snf /usr/share/zoneinfo/$TIMEZONE /etc/localtime && \
  dpkg-reconfigure -f noninteractive tzdata && \
  apt-get clean

# Install dependencies
RUN apt-get update \
 && apt-get -y install \
    gir1.2-gexiv2-0.10 \
    gir1.2-gtk-3.0 \
    gir1.2-osmgpsmap-1.0 \
    graphviz \
    librsvg2-2 \
    python3-bsddb3 \
    python3-gi \
    python3-gi-cairo \
    python3-pillow \
    python3-pip \
    xdg-utils \
    xvfb \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

ADD https://github.com/gramps-project/gramps/releases/download/v5.1.3/gramps_5.1.3-1_all.deb /tmp/gramps.deb
RUN dpkg -i /tmp/gramps.deb \
 && rm /tmp/gramps.deb

CMD gramps
