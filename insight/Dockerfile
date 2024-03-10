FROM ubuntu:16.04

# deps
RUN apt update
RUN apt install -y software-properties-common
RUN add-apt-repository ppa:bitcoin/bitcoin
RUN apt update

# asdf deps
RUN apt install -y curl git build-essential

# install nodejs

SHELL ["/bin/bash", "--login", "-i", "-c"]
RUN git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0
RUN echo ". $HOME/.asdf/asdf.sh" >> ~/.bashrc
RUN source ~/.bashrc 
RUN asdf plugin add nodejs && asdf install nodejs 8.17.0 && asdf global nodejs 8.17.0 
RUN ln -s /root/.asdf/shims/node /usr/bin
SHELL ["/bin/bash", "--login", "-c"]

# bitcoin deps
RUN apt install -y libboost-all-dev libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev
RUN apt install -y libdb4.8-dev libdb4.8++-dev libminiupnpc-dev
RUN apt install -y libevent-dev
RUN apt install -y libzmq5

# install insight

SHELL ["/bin/bash", "--login", "-i", "-c"]

RUN mkdir -p ~/.litecoin/data
COPY chaucha-insight/litecore-node.json /root/.litecoin
COPY config/bitcoin.conf /root/.litecoin/data

#WORKDIR /
COPY config/start.sh /root/start.sh
RUN chmod +x /root/start.sh

ENTRYPOINT ["/root/start.sh"]
