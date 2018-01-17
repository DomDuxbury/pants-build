FROM openjdk

ENV PACKAGES="\
  git \
  python \
  python-dev \
  python-pip \
  curl \
  g++ \
  libffi-dev \
"

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y $PACKAGES

RUN pip install --upgrade pip && \
    pip install virtualenv

WORKDIR /opt/build

COPY ./pants ./pants
COPY ./pants.ini ./pants.ini

RUN ./pants -V
RUN ./pants binary

ENTRYPOINT ["./pants"]
