// Defines a module "anycodeComponents" that depends on another module called
// "riot" and another module called "classlist-polyfill".

(function (root, factory) {
    if (typeof define === 'function' && define.amd) {
        // AMD. Register as an anonymous module.
        define(['exports', 'riot', 'classlist-polyfill'], function (exports, riot) {
            factory((root.anycodeComponents = exports), riot);
        });
    } else if (typeof exports === 'object') {
        // CommonJS
        factory(exports, require('riot'), require('classlist-polyfill'));
    } else {
        // Browser globals
        factory((root.anycodeComponents = {}), root.riot);
    }
}(this, function (exports, riot) {
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
}));
