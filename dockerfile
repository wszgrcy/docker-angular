FROM ubuntu
ENV DEBIAN_FRONTEND noninteractive
ADD ./node-v10.16.2-linux-x64.tar.xz /dependency
VOLUME [ "/data" ]
RUN ln -s /dependency/node-v10.16.2-linux-x64/bin/npm /usr/bin/ \
&& ln -s  /dependency/node-v10.16.2-linux-x64/bin/node /usr/bin/ \
&&apt-get update&&apt-get install -y gcc g++ curl gnupg apt-utils git python3 python\
&&curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg |  apt-key add - \
&&echo "deb https://dl.yarnpkg.com/debian/ stable main" |  tee /etc/apt/sources.list.d/yarn.list \
&&  apt-get update   \
&&  apt-get install --no-install-recommends yarn 