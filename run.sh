if [[ -z $1 ]]; then
  echo "Please specify file name..."
else
  chmod 700 encode.sh
  ./encode.sh $1 # encodes specified video in three resolutions (360p, 720p, 1080p)
  if [[ -f "media/$1/master.m3u8" ]]; then
    go run main.go # starts server on port $1
  fi
fi