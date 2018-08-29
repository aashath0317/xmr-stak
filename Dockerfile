# Latest version of ubuntu
FROM ubuntu:16.04

# Default git repository
ENV GIT_REPOSITORY https://github.com/cbwang2016/xmr-stak.git
ENV XMRSTAK_CMAKE_FLAGS -DXMR-STAK_COMPILE=generic -DCUDA_ENABLE=OFF -DOpenCL_ENABLE=OFF -DHWLOC_ENABLE=OFF

# Innstall packages
RUN apt-get update \
    && set -x \
    && apt-get install -qq --no-install-recommends -y wget ca-certificates cmake g++ make build-essential libhwloc-dev libmicrohttpd-dev libssl-dev git \
    && git clone $GIT_REPOSITORY \
    && cd /xmr-stak \
    && cmake ${XMRSTAK_CMAKE_FLAGS} . \
    && make \
    && cd - \
    && mv /xmr-stak/bin/* /usr/local/bin/ \
    && cd /mnt \
    && wget https://raw.githubusercontent.com/cbwang2016/xmr-stak/master/xmrstak/config.txt \
    && wget https://raw.githubusercontent.com/cbwang2016/xmr-stak/master/xmrstak/pools.txt \
    && rm -rf /xmr-stak \
    && apt-get purge -y -qq cmake libhwloc-dev libmicrohttpd-dev libssl-dev g++ make build-essential \
    && apt-get clean -qq \
    && echo "vm.nr_hugepages=128" >> /etc/sysctl.conf \
    && sysctl -p \
    && cd / \
    && wget https://raw.githubusercontent.com/cbwang2016/xmr-stak/master/entrypoint.sh \
	&& chmod +x /entrypoint.sh

VOLUME /mnt

WORKDIR /mnt
EXPOSE 16001/tcp

ENTRYPOINT ["/entrypoint.sh"]
