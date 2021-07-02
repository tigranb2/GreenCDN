const express = require('express');
const bodyParser = require('body-parser');
const http = require('http');
var cors = require('cors');
const app = express();

app.use(bodyParser.urlencoded({ extended: true }));

app.post('/', (req) => {
    http.get(req.body.videosrc, function (res) {
        res.on('data', (chunk) => {
            console.log(retrieveStreamInfo(chunk))
        });
    }).on('error', (e) => {
        console.log('Got error: ' + e.message);
    });
});

const port = 5000;

app.use(cors());
app.use(express.static('.'))

app.listen(port, () => {
    console.log(`Server running on port ${port}`);
});

function retrieveStreamInfo(data){
    let str = data.toString().replace(/^\s+|\s+$/g, ''); //remove newlines at the end
    let paragraphs = str.split("\n\n");
    var streamInfo = [];
    for (i = 0; i < paragraphs.length; i++){
        const lines = paragraphs[i].split("\n");
        const streamLocation = lines[lines.length-1];
        const resolution = lines[lines.length-2].split('RESOLUTION=').pop().split(',')[0]
        const qualityInfo = resolution + ": " + streamLocation;
        streamInfo.push(qualityInfo);
    }
    return streamInfo;
}