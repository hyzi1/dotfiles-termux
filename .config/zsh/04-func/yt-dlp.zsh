# pkg i nodejs aria2 ffmpeg python

# python3 -m pip install --upgrade "yt-dlp[default,curl-cffi]" && python3 -m pip install mutagen

# yt-dlp/video

# I have 1TB, which is why I want to download everything in high quality.
ytv() {
    if [ $# -eq 0 ]; then
        echo "Use: ytv URL / ytv -a list.txt"
        return 1
    fi

    yt-dlp \
        --js-runtimes node \
        -P "$HOME/storage/downloads/add/vi/" \
        --downloader aria2c \
        --downloader-args "aria2c:-x 16 -s 16 -k 1M" \
        --write-thumbnail \
        -f "bv*[height<=1080][fps=60][vcodec^=avc]+ba[acodec=opus]/bv*[height<=1080][fps=60]+ba/bv*[height<=1080]+ba/b" \
        --merge-output-format mkv \
        --write-auto-subs \
        --sub-langs "es,en" \
        --convert-subs srt \
        --sleep-subtitles 55 \
        --sleep-requests 2 \
        --impersonate chrome \
        -P "subtitle:$HOME/storage/downloads/add/vi/subs/" \
        --embed-thumbnail \
        "$@"
# My configuration is very aggressive, which causes YouTube to block me; that’s why I use: --sleep-subtitles 55.
}

# yt-dlp/audio

yta() {
    if [ -z "$1" ]; then
        echo "Use: ytv URL / ytv -a list.txt"
        return 1
    fi

    yt-dlp \
        --js-runtimes node \
        -P "$HOME/storage/downloads/add/au/" \
        --downloader aria2c \
        --downloader-args "aria2c:-x 16 -s 16 -k 1M" \
        -f "ba[acodec^=opus]/ba" \
        -x \
        --audio-format opus \
        --embed-thumbnail \
        --embed-metadata \
        "$@"
}
# You can use a list.txt file to include your links: yta -a list.txt
