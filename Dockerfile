FROM ubuntu:18.04

ARG USER_ID=1000
ARG GROUP_ID=1000

RUN useradd -r --uid ${USER_ID} devuser && echo "devuser:password" | chpasswd
RUN groupadd -r --gid ${GROUP_ID} devgroup

RUN apt-get -y update && apt-get -y upgrade
RUN apt-get install -y gcc git wget make libncurses-dev flex bison gperf python python-serial python-pip

RUN wget https://dl.espressif.com/dl/xtensa-lx106-elf-gcc8_4_0-esp-2020r3-linux-amd64.tar.gz

RUN mkdir -p /opt/esp/src && \
	cd /opt/esp && \
	tar -xzf /xtensa-lx106-elf-gcc8_4_0-esp-2020r3-linux-amd64.tar.gz

RUN rm /xtensa-lx106-elf-gcc8_4_0-esp-2020r3-linux-amd64.tar.gz

ENV PATH="${PATH}:/opt/esp/xtensa-lx106-elf/bin"

RUN cd /opt/esp && \
	git clone --recursive https://github.com/espressif/ESP8266_RTOS_SDK.git

ENV IDF_PATH="/opt/esp/ESP8266_RTOS_SDK"
ADD sdkconfig /opt/esp/ESP8266_RTOS_SDK/examples/get-started/hello_world/sdkconfig

RUN python -m pip install -r $IDF_PATH/requirements.txt

ADD entrypoint.sh /

RUN chown -R devuser:devgroup /opt/esp
RUN chmod a+x ./entrypoint.sh

USER devuser:devgroup

ENTRYPOINT [ "/entrypoint.sh" ] 
CMD [ "exit" ]