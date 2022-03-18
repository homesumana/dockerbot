FROM python:3.9

RUN mkdir /mybot \
  && apt-get update \
  && apt-get -y install sudo curl vim-tiny \
  && apt-get clean

WORKDIR /mybot

RUN  apt-get update \
  && apt-get -y install build-essential libssl-dev git libffi-dev python-dev \ 
  && pip install --upgrade pip \
  && pip install pyinstaller ccxt bitkub openpyxl line_notify \
  && pip install paho-mqtt \
  && apt-get clean
  
RUN  apt-get update \
  && pip install flask \
  && apt-get clean

# TA-Lib
RUN  apt-get update \
  && apt-get -y install libgfortran5 pkg-config cmake gcc \
  && apt-get clean
RUN mkdir /opt/ta && \
  cd /opt/ta && \
  wget http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz && \
  tar -xvzf ta-lib-0.4.0-src.tar.gz && \
  cd ta-lib/ && \
  ./configure --prefix=/usr && \
  make && \
  make install && \
  rm -rf /opt/ta
RUN pip install numpy TA-Lib

#COPY requirements.txt ./
#RUN pip install --no-cache-dir -r requirements.txt

#COPY . .
#COPY mybot/* /mybot

#CMD [ "python", "mqtt_client_trade_bot_test.py" ]
