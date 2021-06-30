if [[ -z $2 ]]; then
  echo "Please specify port and file name..."
else
  chmod 700 encode.sh
  ./encode.sh $2 # encodes specified video in three resolutions (360p, 720p, 1080p)
  if [[ -f "media/$2/master.m3u8" ]]; then
    go run main.go $1 & # starts server on port $1
    node network-layer.js # starts network layer
    kill $!
  fi
fi