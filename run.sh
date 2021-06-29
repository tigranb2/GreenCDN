if [[ -z $2 ]]; then
  echo "Please specify port and file name..."
else
  ./encode.sh $2 # encodes specified video in three resolutions (360p, 720p, 1080p)
  go run main.go $1 & # starts server on port $1
  nodejs network-layer.js # starts network layer
fi