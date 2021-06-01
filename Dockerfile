FROM ubuntu:18.04

# Install packages
RUN apt-get update \
 && apt-get install -y language-pack-ja sudo curl wget git \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# System settings
ENV TZ Asia/Tokyo
ENV LANG ja_JP.UTF-8

# Make runner user
RUN useradd runner -m \
 && echo runner:runner | chpasswd \
 && usermod -aG sudo runner

USER runner
WORKDIR /home/runner

# Install the actions-runner
RUN mkdir actions-runner \
 && cd actions-runner \
 && curl -o actions-runner-linux-x64-2.278.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.278.0/actions-runner-linux-x64-2.278.0.tar.gz \
 && tar xzf ./actions-runner-linux-x64-2.278.0.tar.gz \
 && rm ./actions-runner-linux-x64-2.278.0.tar.gz

# Install dependencies for actions-runner
USER root
RUN cd actions-runner \
 && ./bin/installdependencies.sh \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Adding the CodeQL runnner
RUN wget https://github.com/github/codeql-action/releases/latest/download/codeql-runner-linux \
 && chmod a+x codeql-runner-linux \
 && mv codeql-runner-linux /usr/local/bin

USER runner
COPY init.sh /home/runner/init.sh
CMD [ "./init.sh" ]
