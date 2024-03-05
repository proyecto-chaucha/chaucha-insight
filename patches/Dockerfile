FROM ubuntu:16.04 AS build

# deps
RUN apt update
RUN apt install -y software-properties-common
RUN add-apt-repository ppa:bitcoin/bitcoin
RUN apt update

# asdf deps
RUN apt install -y curl git build-essential

# zeromq deps
RUN apt-get install -y libunwind-dev libtool pkg-config autoconf automake uuid-dev

# install python and nodejs
RUN apt install -y zlib1g-dev liblzma-dev
RUN apt install -y libncurses5-dev libtk8.5 libgdm-dev libdb4o-cil-dev libpcap-dev
RUN apt install -y libbz2-dev libssl-dev libreadline-dev \
                        libffi-dev libsqlite3-dev tk-dev
RUN apt-get install -y libpng-dev libfreetype6-dev   

SHELL ["/bin/bash", "--login", "-i", "-c"]
RUN git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0
RUN echo ". $HOME/.asdf/asdf.sh" >> ~/.bashrc
RUN source ~/.bashrc 
RUN asdf plugin add nodejs && asdf install nodejs 8.17.0 && asdf global nodejs 8.17.0 
RUN asdf plugin add python && asdf install python 3.6.15 && asdf global python 3.6.15
SHELL ["/bin/bash", "--login", "-c"]

# bitcoin deps
RUN apt install -y libboost-all-dev libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev
RUN apt install -y libdb4.8-dev libdb4.8++-dev libminiupnpc-dev
RUN apt install -y libevent-dev
RUN apt install -y libzmq5

# install insight
# WORKDIR /insight
RUN mkdir -p ~/insight/config
RUN mkdir -p ~/insight/chaucha-insight

COPY chaucha.conf /root/insight/config

COPY chauchad /root/insight/chaucha-insight
COPY package.json /root/insight/chaucha-insight

COPY litecore-node.json /root/insight
COPY chaucheracore.patch /root/insight
COPY insight-chaucha.patch /root/insight

#RUN ls ~/insight && cat ~/insight/litecore-node.json

RUN cp ~/insight/config/chaucha.conf ~/insight/config/bitcoin.conf
RUN sed -e "s|DATADIR|$HOME/insight/config|" -e "s|CHAUCHAD|$HOME/insight/chaucha-insight/chauchad|" ~/insight/litecore-node.json > ~/insight/chaucha-insight/litecore-node.json

SHELL ["/bin/bash", "--login", "-i", "-c"]
RUN source ~/.bashrc && cd ~/insight/chaucha-insight/ && npm install

WORKDIR /root/insight/chaucha-insight
RUN patch -p0 < ~/insight/insight-chaucha.patch
COPY address.js /root/insight/chaucha-insight/node_modules/insight-api/node_modules/bitcore-lib/lib/address.js
COPY unit.js /root/insight/chaucha-insight/node_modules/insight-api/node_modules/bitcore-lib/lib/unit.js
RUN rm -f node_modules/litecore-node/bin/litecoind
RUN cd node_modules/litecore-node/bin && ln -sf ~/insight/chaucha-insight/chauchad litecoind
RUN cd node_modules/litecore-node/bin && ln -sf ~/insight/chaucha-insight/chauchad chauchad
RUN echo "$HOME/insight/chaucha-insight/node_modules/litecore-node/bin/litecore-node start" > /start.sh && chmod +x /start.sh
RUN rm /usr/bin/python3
RUN ln -s /root/.asdf/shims/python3 /usr/bin
RUN ln -s /root/.asdf/shims/node /usr/bin
#SHELL ["/bin/bash", "--login", "-c"]

RUN mkdir -p ~/.litecoin/data
RUN cp ~/insight/chaucha-insight/litecore-node.json ~/.litecoin
RUN cp ~/insight/config/bitcoin.conf ~/.litecoin/data

WORKDIR /

#SHELL ["/bin/bash", "--login", "-i", "-c"]
# entrypoint
#CMD ["/root/insight/chaucha-insight/node_modules/litecore-node/bin/litecore-node start"]
#RUN echo "source $HOME/.bashrc && python3 -m http.server" > /python.sh && chmod +x /python.sh
#ENTRYPOINT ["/python.sh"]
#SHELL ["/bin/bash", "--login", "-c"]


#ENTRYPOINT ["/root/.asdf/shims/python3", "-m", "http.server"]
ENTRYPOINT ["/root/insight/chaucha-insight/node_modules/litecore-node/bin/litecore-node", "start"]
