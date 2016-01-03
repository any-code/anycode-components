function Module(exports, riot) {
    var _reference = [];

    //
    //
    // Am i a mixin?
    // riot.mixin('animation-context', { animation-context: library })

    //
    //
    // BEGIN RIOT TAGS

    // END RIOT TAGS
    //
    //
}

Module.prototype.dependencies = ['riot', 'classlist-polyfill']
Module.prototype.global = "anycode-components";

// Module UMD Loader
(function (g, f) {
    var d=Module.prototype.dependencies,gn=Module.prototype.global
    if (typeof define==='function'&&define.amd){define(['exports'].concat(d||[]),f)}else if(typeof exports==='object'&&
        typeof exports.nodeName!=='string'){f.apply(this,[exports].concat(d?d.map(require):[]))}else{if(typeof gn==='string'
    )gn=[gn];g[gn[0]]={};gn.splice(1).map(function(d){g[d]=g[gn[0]]});f.apply(this, [g[gn[0]]].concat(d?d.map(function(d
    ){return g[d]}):[]))}
}(this, Module));
