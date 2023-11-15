FROM python:3.8-slim-buster

RUN apt-get update \
    && apt-get -y install curl gcc ffmpeg python3 python3-pip git \
    && curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp \
    && chmod a+rx /usr/local/bin/yt-dlp \
    && yt-dlp -U \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install --upgrade pip --no-cache-dir
RUN pip3 install -U yt-dlp --no-cache-dir

WORKDIR /music
RUN chmod 755 /music

COPY requirements.txt .
RUN pip3 install -r requirements.txt --no-cache-dir

COPY . .

CMD ["python3", "-m", "mbot"]
