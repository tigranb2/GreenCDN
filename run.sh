if [[ -z $1 ]]; then
  echo "Please specify port and file name..."
else
  cd media/$2
  find . -type f ! -name '*.mp4' -delete && find . -type d ! -name '*.mp4' -delete # delete all files except for mp4
  ffmpeg -i $2.mp4 \
  -filter_complex \
  "[0:v]split=3[v1][v2][v3]; \
  [v1]scale=w=1920:h=1080[v1out]; [v2]scale=w=1280:h=720[v2out]; [v3]scale=w=640:h=360[v3out]" \
  -map [v1out] -c:v:0 libx264 -x264-params "nal-hrd=cbr:force-cfr=1" -b:v:0 5M -maxrate:v:0 5M -minrate:v:0 5M -bufsize:v:0 10M -preset slow -g 48 -sc_threshold 0 -keyint_min 48 \
-map [v2out] -c:v:1 libx264 -x264-params "nal-hrd=cbr:force-cfr=1" -b:v:0 3M -maxrate:v:0 3M -minrate:v:0 3M -bufsize:v:0 3M -preset slow -g 48 -sc_threshold 0 -keyint_min 48 \
-map [v3out] -c:v:2 libx264 -x264-params "nal-hrd=cbr:force-cfr=1" -b:v:0 1M -maxrate:v:0 1M -minrate:v:0 1M -bufsize:v:0 1M -preset slow -g 48 -sc_threshold 0 -keyint_min 48 \-map a:0 -c:a:0 aac -b:a:0 96k -ac 2 \
  -map a:0 -c:a:1 aac -b:a:1 96k -ac 2 \
  -map a:0 -c:a:2 aac -b:a:2 48k -ac 2 \
  -var_stream_map "v:0,a:0 v:1,a:1 v:2,a:2" \
  -master_pl_name master.m3u8 \
  -f hls -hls_time 2 -hls_playlist_type vod -hls_flags independent_segments -hls_segment_type mpegts \
  -hls_segment_filename "%v/fileSequence%d.ts" \
  %v/prog_index.m3u8
  cd .. && cd ..
  go run main.go $1 & # starts server
  nodejs network-layer.js # starts network layer
fi