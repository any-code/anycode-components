if (!process.argv[4]) {
    console.log("usage: node pack.js {template} {glob} {output}");
    return;
}

var fs = require('fs'),
    file = fs.readFileSync(process.argv[2], 'utf-8'),
    js = '',
    packed = '',
    riot = require('riot');

for (var i = 3; i < process.argv.length -1; i++) {
    if (process.argv[i].substr(process.argv[i].length - 4) === '.tag') {
        js = js + riot.compile(fs.readFileSync(process.argv[i], 'utf-8')) + "\n\n"
        packed = packed + ' ' + process.argv[i];
    }
}

file = file.replace(/\/\/\sBEGIN\sRIOT\sTAGS[\s\S]+\/\/\sEND\sRIOT\sTAGS/, "//BEGIN RIOT TAGS\n" +
    js + "        //END RIOT TAGS");
fs.writeFile(process.argv[process.argv.length - 1], file);
console.log('packed:' + packed);

