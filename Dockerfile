FROM debian:stable-slim

ENV TERRAFORM_VERSION 0.11.13
ENV ANSIBLE_VERSION 2.7.10
ENV GOOGLE_AUTH_VERSION 1.6.3
ENV REQUESTS_VERSION 2.21.0
ENV EDITOR vim

RUN apt-get -y update && \
    apt-get -y install \
        openssh-client \
        python \
        python-pip \
        unzip \
        git \
        vim \
        jq \
        && \
    apt-get -y autoremove && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/*

WORKDIR /polkadot

RUN pip install \
        ansible==${ANSIBLE_VERSION} \
        requests==${REQUESTS_VERSION} \
        google-auth==${GOOGLE_AUTH_VERSION}

ADD https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip /tmp/

RUN unzip /tmp/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/local/bin/ && \
    rm /tmp/terraform_${TERRAFORM_VERSION}_linux_amd64.zip

RUN groupadd -r polkadot && useradd --no-log-init -m -r -g polkadot polkadot

COPY tools/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
