var Tiler = require('./tile.js');
const fs = require('fs');
const path = require('path');
var tiler = new Tiler('chengle/v101/Layers', { packSize: 128 });

let minz=0, maxz=20;
let earthR=6378137;
let tileSize=256;
//let minxx=11641356.4123209;
//let maxxx=11718229.9676737;
//let minyy=3463240.53232053;
//let maxyy=3521082.16338265;
//top：3341688.33962007
//bellow：3323637.8548289
//left：11544035.9519079
//right：11569674.6032469
let minxx=11544035.9519079;
let maxxx=11569674.6032469;
let minyy=3323637.8548289;
let maxyy=3341688.33962007;

var doExe = function (x, y, z, callback) {
  setTimeout(function () {
    tiler.getTile(x, y, z, function(error, tile) {
      if (error || !tile.data.length || tile.data.length==190) ;
      else {
        let pngPath = path.resolve('pngs/'+z+'/'+x+'/');
        fs.existsSync(pngPath) == false && mkdirs(pngPath);
        fs.writeFileSync(pngPath+"/"+y+'.png', tile.data);
        console.info(pngPath+"/"+y+'.png');
      }
    });
//      console.info(z+'_'+x+'_'+y+'.png');
    if (callback) {
      callback()
    }
  }, 0)
};

//async
(async () => {
  for (let z = minz;  z <= maxz; z++) {
    let halfLen=Math.PI*earthR;
    minx=Math.floor((minxx+halfLen)/(2*halfLen)*Math.pow(2,z));
    maxx=Math.floor((maxxx+halfLen)/(2*halfLen)*Math.pow(2,z));
    miny=Math.floor((halfLen-maxyy)/(2*halfLen)*Math.pow(2,z));
    maxy=Math.floor((halfLen-minyy)/(2*halfLen)*Math.pow(2,z));
    for (let y = miny; y <= maxy; y++) {
      for (let x = minx; x <= maxx; x++) {
         await new Promise(resolve => doExe(x, y, z, resolve));
      }
    }
  }
})();

function mkdirs(dirpath) {
    if (!fs.existsSync(path.dirname(dirpath))) {
      mkdirs(path.dirname(dirpath));
    }
    fs.mkdirSync(dirpath);
}
