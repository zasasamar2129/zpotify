FROM python:3.8-slim-buster

RUN apt-get update \
    && apt update && apt upgrade -y \
    && apt-get -y update; apt-get -y install curl \
    && curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp \
    && chmod a+rx /usr/local/bin/yt-dlp \
    && yt-dlp -U \
    && apt-get install -y --no-install-recommends python3-pip git \
    && rm -rf /var/lib/apt/lists/*
RUN pip3 install --upgrade pip
RUN python3 -m pip install -U yt-dlp
RUN pip install -U yt-dlp
WORKDIR /music
RUN chmod 777 /music
RUN apt update && apt upgrade -y && apt install gcc  ffmpeg python3 python3-pip -y
COPY requirements.txt .
RUN pip3 install -r requirements.txt
RUN python3 -m pip install -U yt-dlp
COPY . .
CMD ["python3", "-m", "mbot"]
