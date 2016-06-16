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
    //BEGIN RIOT TAGS
riot.tag2('iconic-announcement', '<div class="loader"> <svg xmlns="http://www.w3.org/2000/svg" version="1.1" width="70px" height="70px" viewbox="0 0 500 500"> <path name="loader" transform="translate(250, 250) scale(4.2)"></path> </svg> </div> <iconic-button class="close" onclick="{hide}">&times;</iconic-button> <div class="badge"> <i class="{opts.icon}"></i> </div> <div class="content" onclick="{wait}"> <yield></yield> </div>', 'iconic-announcement,[riot-tag="iconic-announcement"] { display: block; position: fixed; top: -16rem; left: 0; right: 0; height: 8rem; transition: all 300ms ease-in-out; overflow: hidden; z-index: 200; } iconic-announcement.show,[riot-tag="iconic-announcement"].show { top: 0rem; } iconic-announcement .close,[riot-tag="iconic-announcement"] .close { color: rgba(255,255,255,0.6); float: right; width: 8rem; height: 8rem; border: none; } iconic-announcement .close:hover,[riot-tag="iconic-announcement"] .close:hover { color: rgba(255,255,255,0.6); } iconic-announcement .close div[name="text"],[riot-tag="iconic-announcement"] .close div[name="text"] { font-weight: 600; font-size: 10rem; line-height: 5.5rem; } iconic-announcement .badge,[riot-tag="iconic-announcement"] .badge { padding: 1rem; position: relative; height: 6rem; width: 6rem; font-size: 6rem; line-height: 5rem; } iconic-announcement .content,[riot-tag="iconic-announcement"] .content { position: absolute; height: 6rem; top: 0rem; left: 8rem; width: auto; right: 8rem; font-size: 1.8rem; font-weight: bolder; padding:1rem; display: table-cell; vertical-align: middle; } iconic-announcement .loader,[riot-tag="iconic-announcement"] .loader { padding: 0.5rem; position: absolute; top: 0; right: 0; height: 7rem; width: 7rem; } iconic-announcement path[name="loader"],[riot-tag="iconic-announcement"] path[name="loader"] { fill: rgba(0, 0, 0, 0.5); }', '', function(opts) {
        var DEFAULT_TIMEOUT = 10000,
            showing,
            drawing,
            angle = 0,
            interval,
            loader;

        function reset() {
            angle = 0
            loader.setAttribute( 'd', 'M 0 0 v -250 A 250 250 1 0 1 0 -250 z' )
        }

        function drawDeg(angle) {
            angle++
            angle %= 360;

            var r = ( angle * Math.PI / 180 ),
                x = Math.sin( r ) * 250,
                y = Math.cos( r ) * - 250,
                mid = ( angle > 180 ) ? 1 : 0,
                anim = 'M 0 0 v -250 A 250 250 1 ' + mid + ' 1 ' +  x  + ' ' +  y  + ' z';

            loader.setAttribute( 'd', anim )
        }

        function drawDegFromTo(angle, end) {

            angle++
            angle %= end;

            var r = ( angle * Math.PI / 180 ),
                x = Math.sin( r ) * 250,
                y = Math.cos( r ) * - 250,
                mid = ( angle > 180 ) ? 1 : 0,
                anim = 'M 0 0 v -250 A 250 250 1 ' + mid + ' 1 ' +  x  + ' ' +  y  + ' z';

            loader.setAttribute( 'd', anim )
            if (Math.abs(angle) <= 1) {
                clearTimeout(drawing);
                drawDeg(end);
            } else {
                drawing = setTimeout(function() {
                    drawDegFromTo(angle, end);
                }, 5);
            }
        }

        function drawProgress() {
            angle++;
            angle %= 360;
            var r = ( angle * Math.PI / 180 ),
                x = Math.sin( r ) * 250,
                y = Math.cos( r ) * - 250,
                mid = ( angle > 180 ) ? 1 : 0,
                anim = 'M 0 0 v -250 A 250 250 1 ' + mid + ' 1 ' +  x  + ' ' +  y  + ' z'
            loader.setAttribute( 'd', anim )
            if( angle != 0 ) {
                drawing = setTimeout(drawProgress, interval);
            }
        }

        this.wait = function() {
            reset()
            clearTimeout(drawing)
            clearTimeout(showing)
        }

        this.on('mount', function() {
            loader = this.loader;
            border = this.border;
        });

        this.show = function(timeout) {
            this.hide();
            interval = Math.floor((parseInt(timeout - 250, 10) || DEFAULT_TIMEOUT - 250) / 360);
            this.root.classList.add('show')
            if (timeout) {
                this.loader.style.display = 'block';
                reset()
                clearTimeout(drawing)
                clearTimeout(showing)
                drawProgress();
                showing = setTimeout(function() {
                    this.hide();
                }.bind(this), timeout || DEFAULT_TIMEOUT);
            } else {
                this.loader.style.display = 'none';
            }
        }.bind(this)

        this.hide = function() {
            reset();
            clearTimeout(drawing)
            clearTimeout(showing)
            this.root.classList.remove('show')
        }.bind(this)

}, '{ }');


riot.tag2('iconic-button', '<div name="container" class="inner"> <div name="text"><yield></yield></div> <div name="hotkey">{keyHelp[0]}</div> </div>', 'iconic-button,[riot-tag="iconic-button"] { display: inline-block; position: relative; cursor: pointer; } iconic-button .inner,[riot-tag="iconic-button"] .inner { line-height: 2.6rem; } iconic-button .inner i,[riot-tag="iconic-button"] .inner i { vertical-align: middle; } iconic-button div[name="hotkey"],[riot-tag="iconic-button"] div[name="hotkey"] { position: absolute; display: block; opacity: 0; background: rgba(255,255,255,1); border: 1px solid rgba(0,0,0,0.2); line-height: 2.6rem; position: absolute; z-index: 5; top: 0; left: 0; right: 0; bottom: 0; color: rgba(0,0,0,0.8); font-weight: 600; text-align: center; vertical-align: center; transition: all 200ms ease-in-out; transition-delay: 0ms; -webkit-user-select: none; -moz-user-select: none; -ms-user-select: none; user-select: none; margin-top: 0%; font-size: 100%; } iconic-button div[name="hotkey"].help,[riot-tag="iconic-button"] div[name="hotkey"].help { opacity: 1; }', '', function(opts) {
        this.on('mount', function() {
            this.root.classList.add('button');
            this.root.classList.add('icon-extra-small');
            this.keyHelp = [];

            document.body.addEventListener('keypress', function(event) {
                event = event || window.event;
                var key = event.which, name = event.target.nodeName.toUpperCase();

                if (key === 0 || event.target.contentEditable.toUpperCase() === "TRUE" || name === "TEXTAREA" ||
                    name === "INPUT") { return true; }
                if (this.keyHelp && this.keyHelp.indexOf(String.fromCharCode(key)) > -1) {
                    this.activated = key;
                    return false;
                }
            }.bind(this))

            document.body.addEventListener('keyup', function(event) {
                event = event || window.event;
                var key = event.which, name = event.target.nodeName.toUpperCase();
                if (key === 0 || event.target.contentEditable.toUpperCase() === "TRUE" || name === "TEXTAREA" ||
                    name === "INPUT") { return true; }

                var visualClick = function() {
                    if (this.activated) {
                        this.activated = false;
                        this.container.classList.add('activated');
                        this.root.click();
                        setTimeout(function () {
                            this.container.classList.remove('activated');
                        }.bind(this), 600)
                    }
                }.bind(this)

                if (this.hotkey.classList.contains('help')) {
                    visualClick();
                    setTimeout(function() {
                        this.hotkey.classList.remove('help')

                    }.bind(this), 200);
                } else {
                    visualClick();
                }
            }.bind(this))

            document.body.addEventListener('keydown', function(event) {
                event = event || window.event;
                var key = event.which, name = event.target.nodeName.toUpperCase();
                if (key === 0 || event.target.contentEditable.toUpperCase() === "TRUE" || name === "TEXTAREA" ||
                    name === "INPUT") { return true; }
                if (event.shiftKey && event.ctrlKey && this.keyHelp) {
                    this.hotkey.classList.add('help')
                } else {
                    this.hotkey.classList.remove('help')
                }
                return true;
            }.bind(this));
        })

        this.on('mount update', function() {
            this.keyHelp = opts.hotkey || undefined;
        });
}, '{ }');


riot.tag2('iconic-dropdown', '<div name="dd" class="dd"> <div name="ddTrigger" onclick="{onTriggerClick}" class="dd-trigger opener u-nd button button-extra-small"><yield from="trigger"></yield></div> <div name="ddContent" class="dd-content"> <yield from="links"></yield> </div> </div>', 'iconic-dropdown,[riot-tag="iconic-dropdown"] { display: inline-block; } iconic-dropdown .dd,[riot-tag="iconic-dropdown"] .dd { position: relative; display: inline-block; } iconic-dropdown .dd-trigger,[riot-tag="iconic-dropdown"] .dd-trigger { cursor: pointer; padding:0; min-width: 3rem; font-size: 1.2rem; line-height: 3.2rem; } iconic-dropdown .dd-trigger i,[riot-tag="iconic-dropdown"] .dd-trigger i { padding-left: 0.8rem; } iconic-dropdown .dd-trigger span,[riot-tag="iconic-dropdown"] .dd-trigger span { padding-left: 0.8rem; } iconic-dropdown .dd-trigger i:only-child,[riot-tag="iconic-dropdown"] .dd-trigger i:only-child { padding: 0; } iconic-dropdown .dd-trigger i + span,[riot-tag="iconic-dropdown"] .dd-trigger i + span { padding-left: 0.5rem; padding-right: 0.8rem } iconic-dropdown .dd-trigger span + i,[riot-tag="iconic-dropdown"] .dd-trigger span + i { padding-right: 0.8rem } iconic-dropdown .dd-content a,[riot-tag="iconic-dropdown"] .dd-content a { display: block; padding: 0.7rem 1rem; font-size: 1.2rem; text-transform: uppercase; } iconic-dropdown .dd-content,[riot-tag="iconic-dropdown"] .dd-content { display: none; } iconic-dropdown .open .dd-content,[riot-tag="iconic-dropdown"] .open .dd-content { display:block; }', '', function(opts) {

        this.onTriggerClick = function(event) {

            this.ddContent.style.minWidth = (this.ddTrigger.clientWidth) + 'px'

            this.dd.classList.toggle("open")

            this.ddTrigger.clientWidth < this.ddContent.clientWidth ?
                this.dd.classList.add('oversize') : this.dd.classList.remove('oversize')

        }.bind(this)

        this.onWindowClick = function(event) {

            var t = event.target
            while (t && !t.classList.contains('dd-trigger')) t = t.parentElement

            if (t && t == this.ddTrigger) return

            this.dd.classList.remove("open")
        }

        this.on('mount', function() {

            window.addEventListener('click', this.onWindowClick.bind(this), false)
        })

        this.on('unmount', function() {

            window.removeEventListener('click', this.onWindowClick.bind(this), false)
        })

}, '{ }');


riot.tag2('iconic-footer', '<article class="{\'u-pn\': pageHasNavigation}"> <div class="container"> <div class="row"> <div class="twelve columns links"> <i class="f-brand icon-anycode-badge"></i> <p class="f-tagline u-center-text">Create, Inspire, Be Anything.</p> <yield></yield> <div class="copy u-center-text"> copyright &copy; 2015-{year} <em>{opts.product}</em> is a product of Anycode </div> </div> </div> <div class="row"> <div class="columns twelve"> <div class="tested-with u-center-text"> <a class="browser-stack" href="https://www.browserstack.com/" target="_blank"><span>Tested with</span> <img src="https://d3but80xmlhqzj.cloudfront.net/production/images/static/header/header-logo.svg?1451465607"></a> </div> </div> </div> </div> <article>', 'iconic-footer,[riot-tag="iconic-footer"] { display: block; margin: 0; height: auto; padding: 0; position: relative; transition: all 200ms ease-in-out; } iconic-footer .container,[riot-tag="iconic-footer"] .container { padding: 0 1rem; } iconic-footer .f-brand,[riot-tag="iconic-footer"] .f-brand { display: inline-block; line-height: 10rem; position: relative; text-align: center; width: 100%; } iconic-footer .links ul,[riot-tag="iconic-footer"] .links ul { text-align: center; display: block; padding: 0; } iconic-footer .links ul li,[riot-tag="iconic-footer"] .links ul li { text-align: center; display: block; padding: 0; margin: 0 0 0.2rem 0; } iconic-footer .links ul li a,[riot-tag="iconic-footer"] .links ul li a { font-size: 1.1rem; font-weight: 300; text-transform: uppercase; text-align: center; display: block; padding: 0.4rem; transition: all 80ms ease-in-out; text-decoration: none; } iconic-footer .copy,[riot-tag="iconic-footer"] .copy { font-size: 0.9rem; font-weight: 400; padding-top: 1.5rem; } iconic-footer .copy em,[riot-tag="iconic-footer"] .copy em { font-weight: 700; } iconic-footer .tested-with,[riot-tag="iconic-footer"] .tested-with { margin: 0.2rem auto; font-weight: 300; text-align: center; border-radius: 1rem; margin-bottom: 3rem; } iconic-footer .tested-with a,[riot-tag="iconic-footer"] .tested-with a { color: #FFF; text-decoration: none; } iconic-footer .tested-with img,[riot-tag="iconic-footer"] .tested-with img { height: 1.5rem; vertical-align: middle; margin-top: -0.3rem; } @media (min-width: 400px) { iconic-footer .links > ul li,[riot-tag="iconic-footer"] .links > ul li { display: inline-block; } iconic-footer .links > ul li a,[riot-tag="iconic-footer"] .links > ul li a { font-size: 1.1rem; padding: 0.8rem; } iconic-footer .copy,[riot-tag="iconic-footer"] .copy { font-size: 1.1rem; padding-top: 3rem; } }', 'class="{shrink: shrink}"', function(opts) {

        this.year = (new Date()).getFullYear()

        this.gaTrackingCode = opts.gaTrackingCode || 'UA-69299537-1'
        this.gaId = opts.gaId || window.location.host + window.location.pathname + window.location.hash

        this.on('mount', function() {

            (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
                    (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
                m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
            })(window,document,'script','//www.google-analytics.com/analytics.js','ga')
            ga('create', this.gaTrackingCode, 'auto')
            ga('send', 'pageview', this.gaId);
        })
}, '{ }');


riot.tag2('iconic-header', '<div> <yield></yield> <div>', 'iconic-header,[riot-tag="iconic-header"] { display: block; height: 4.2rem; padding: 0; transition: all 200ms ease-in-out; white-space: nowrap; } iconic-header .brand,[riot-tag="iconic-header"] .brand { float: left; display: block; margin-top: 0.8rem; margin-left:1rem; } iconic-header .brand i,[riot-tag="iconic-header"] .brand i { font-size: 1.8rem; vertical-align: middle; } iconic-header .brand span,[riot-tag="iconic-header"] .brand span { font-size: 1.2rem; font-weight: 300; line-height: 1rem; vertical-align: middle; } iconic-header .brand span b,[riot-tag="iconic-header"] .brand span b { font-weight: 700; } iconic-header div > ul,[riot-tag="iconic-header"] div > ul { margin: 0; padding: 0; float: right; } iconic-header div > ul li,[riot-tag="iconic-header"] div > ul li { list-style: none; margin: 0; padding: 0; } iconic-header div > ul.u-pull-right li,[riot-tag="iconic-header"] div > ul.u-pull-right li { padding-right: 0.5rem; } iconic-header div > ul.u-pull-left li,[riot-tag="iconic-header"] div > ul.u-pull-left li { padding-left: 0.5rem; } iconic-header div > ul li.pinned,[riot-tag="iconic-header"] div > ul li.pinned,iconic-header div > ul li.restricted,[riot-tag="iconic-header"] div > ul li.restricted { margin-top: 0.8rem; } iconic-header div > ul li *,[riot-tag="iconic-header"] div > ul li * { margin-top: -2px; } iconic-header div > ul li a,[riot-tag="iconic-header"] div > ul li a { margin-top: 0px; padding-top: 3px; display: block; font-size: 1.4rem; padding: 0.8rem 0.8rem 0 0.8rem; text-align: left; text-decoration: none; transition: all 80ms ease-in-out; } iconic-header div > ul li a.button,[riot-tag="iconic-header"] div > ul li a.button { margin-top: -2px; padding-top: 0; } iconic-header div > ul li.separator,[riot-tag="iconic-header"] div > ul li.separator { width: 0.6rem; }', '', function(opts) {
});


riot.tag2('iconic-links', '<div> <yield></yield> <div>', 'iconic-links,[riot-tag="iconic-links"] { display: block; position: fixed; margin: 0; padding: 0; height: auto; transition: all 200ms ease-in-out; left: 0; right: 0; top:0; height: 4.2rem; z-index:1; background: #FFF; white-space: nowrap; } iconic-links.shrink,[riot-tag="iconic-links"].shrink { padding: 0 1rem 0 4rem; height: auto; position: relative; clear: both; } iconic-links.shrink ul,[riot-tag="iconic-links"].shrink ul { text-align: center; } iconic-links div > ul,[riot-tag="iconic-links"] div > ul { margin: 0; padding: 0; text-align: center; } iconic-links div > ul li,[riot-tag="iconic-links"] div > ul li { padding: 0; margin: 0; list-style: none; display: inline-block; padding-right: 0.5rem; } iconic-links.shrink div > ul li,[riot-tag="iconic-links"].shrink div > ul li { display: block; padding-left:1rem; padding-right: 1rem; } iconic-links.shrink div > ul li a,[riot-tag="iconic-links"].shrink div > ul li a { padding-left:1rem; } iconic-links.shrink div > ul li a.button,[riot-tag="iconic-links"].shrink div > ul li a.button { display: block; margin: 1rem 0 0 1rem; } iconic-links div > ul li a,[riot-tag="iconic-links"] div > ul li a { font-size: 1.5rem; color: rgba(0, 0, 0, 0.7); text-align: left; display: block; padding: 0.8rem; transition: all 80ms ease-in-out; text-decoration: none; } iconic-links div > ul li a.button,[riot-tag="iconic-links"] div > ul li a.button { vertical-align: middle; } iconic-links div > ul li.separator,[riot-tag="iconic-links"] div > ul li.separator { height: 0; border-left: 6px solid white; } iconic-links div > ul li ul,[riot-tag="iconic-links"] div > ul li ul { padding: 0; margin: 0; } iconic-links div > ul li ul li,[riot-tag="iconic-links"] div > ul li ul li { padding: 0; margin: 0; list-style: none; } iconic-links div > ul li ul li a,[riot-tag="iconic-links"] div > ul li ul li a { font-size: 1rem; display: block; padding: 0.1rem 0.1rem 0.1rem 2rem; -webkit-transition: .5s all ease-out; -moz-transition: .5s all ease-out; transition: .5s all ease-out; text-decoration: none; }', 'class="{shrink: shrink}"', function(opts) {
        this.viewing = undefined;
        this.shrink = false;
        this.measured = false;

        this.on('mount', function() {
            this.measured = this.root.scrollWidth;
            this.update({
                shrink: this.root.clientWidth < this.root.scrollWidth
            })
        })

        window.addEventListener('resize', function() {
            this.update({
                shrink: false
            })
            this.update({
                measured: this.root.scrollWidth
            })
            this.update({
                shrink: this.root.clientWidth < this.root.scrollWidth
            })
        }.bind(this))
}, '{ }');


riot.tag2('iconic-menu', '<div name="left" class="arrow-left"></div> <div name="right" class="arrow-right"></div> <div name="content"> <yield></yield> </div>', 'iconic-menu,[riot-tag="iconic-menu"] { position: absolute; display: block; box-shadow: 0 0 0.8rem rgba(0, 0, 0, 0.6); background: #222; padding: 0.3rem 0.2rem 0.2rem 0.3rem; font-size: 1.5rem; border-radius: 0.3rem; color: #FFF; opacity: 0; margin: 0 auto; z-index: -1; transition: z-index 1ms step-end 0ms, opacity 200ms ease-in-out 0ms; -webkit-user-select: none; -moz-user-select: none; -ms-user-select: none; user-select: none; pointer-events: none; } iconic-menu.navigation-tip,[riot-tag="iconic-menu"].navigation-tip { padding: 0.2rem 1rem 0.2rem 0.2rem; border-radius: 0.4rem; } iconic-menu.navigation-tip iconic-button,[riot-tag="iconic-menu"].navigation-tip iconic-button { vertical-align: middle; margin: 0; } iconic-menu.navigation-tip .arrow-right,[riot-tag="iconic-menu"].navigation-tip .arrow-right { top: 0.78rem; } iconic-menu.fixed,[riot-tag="iconic-menu"].fixed { z-index: 9999; position: fixed!important; } iconic-menu.active,[riot-tag="iconic-menu"].active { pointer-events: auto; } iconic-menu .content,[riot-tag="iconic-menu"] .content { padding: 0; margin: 0; } iconic-menu .arrow-left,[riot-tag="iconic-menu"] .arrow-left { position: absolute; width: 0; height: 0; border-top: 10px solid transparent; border-bottom: 10px solid transparent; border-left: 10px solid #222; right: -10px; transition: opacity 200ms ease-in-out; } iconic-menu .arrow-right,[riot-tag="iconic-menu"] .arrow-right { position: absolute; width: 0; height: 0; border-top: 10px solid transparent; border-bottom: 10px solid transparent; border-right: 10px solid #222; left: -10px; transition: opacity 200ms ease-in-out; } iconic-menu.show,[riot-tag="iconic-menu"].show { opacity: 0.95; z-index: 9999; } iconic-menu ul,[riot-tag="iconic-menu"] ul { list-style: none; padding: 0; margin: 0; } iconic-menu ul li,[riot-tag="iconic-menu"] ul li { padding: 0; margin: 0; display: block; position: relative; } iconic-menu div.form,[riot-tag="iconic-menu"] div.form { margin: 0; padding: 1rem; } iconic-menu div.form *,[riot-tag="iconic-menu"] div.form * { margin: 0; padding: 0; } iconic-menu a,[riot-tag="iconic-menu"] a { padding: 0; margin: 0; color: #FFF; cursor: pointer; display: block; position: relative; padding-top: 0rem; padding-bottom: 0rem; padding-right: 2rem; height: 3rem; margin: 0.2rem 0.2rem 0.3rem 0.1rem; border: 0.1rem solid rgba(0,0,0,0); }', '', function(opts) {
        var TRANSITION_TIMESPAN = 200;
        this.timed = [];
        this.queue = [];

        this.on('mount', function() {
            this._initializeTriggers()
            this.root.addEventListener('mouseover', this.cancelHideHandler, true)
        })

        this._showTip = function(target) {
            var el = this._findTarget(target),
                name = this._getPosition(target),
                top = this._measure(el, 'Top'),
                pushUp = this.root.clientHeight + top > window.innerHeight;
            this.root.style.zIndex = 9999;
            this.left.style.display = "none"
            this.right.style.display = "none"
            if (el.clientHeight > 20) {
                if (pushUp) {
                    this.left.style.top = "" + this.root.clientHeight - 8 - (el.clientHeight / 2) + "px";
                    this.right.style.top = "" + this.root.clientHeight - 8 - (el.clientHeight / 2) + "px";
                } else {
                    this.left.style.top = "" + ((el.clientHeight / 2) - 8) + "px";
                    this.right.style.top = "" + ((el.clientHeight / 2) - 8) + "px";
                }
            } else {
                if (pushUp) {
                    this.left.style.top = "" + this.root.clientHeight - 20 - (el.clientHeight / 2) + "px";
                    this.right.style.top = "" + this.root.clientHeight - 20 - (el.clientHeight / 2) + "px";
                } else {
                    this.left.style.top = "" + (((20 - el.clientHeight) / 2) + 10) + "px";
                    this.right.style.top = "" + (((20 - el.clientHeight) / 2) + 10) + "px";
                }
            }
            this[name].style.display = "block"

            if (name=='right') this.root.style.left = "" + (this._measure(el, 'Left') + el.clientWidth + 10) + "px";
            if (name=='left') this.root.style.left = "" + (this._measure(el, 'Left') - this.root.clientWidth - 10) + "px";

            if (el.clientHeight > 20) {
                this.root.style.top = "" + (this.root.clientHeight + top > window.innerHeight ? this._measure(el, 'Top') - (this.root.clientHeight - el.clientHeight - 2) : this._measure(el, 'Top')) + "px";
            } else {
                if (pushUp){
                    this.root.style.top = "" + ((this._measure(el, 'Top') - this.root.clientHeight) + el.clientHeight + 12) + "px";
                } else {
                    this.root.style.top = "" + (this._measure(el, 'Top') - 10) + "px";
                }
            }

            this.root.style.zIndex = 9999;
            this.root.classList.add('fixed')
            this.root.classList.add('active')
            this.root.classList.add('show')
        }

        this._measure = function(el, attr, pixels) {
            if (pixels === undefined) { pixels = 0; }
            if (el == null) {
                return pixels;
            } else {
                pixels = pixels + (el['offset' + attr] - el['scroll' + attr]);
                return this._measure(el.offsetParent, attr, pixels);
            }
        }

        this._findTarget = function(target) {
            do {
                if (target.__tip_target)
                    return target

                target = target.parentElement

            } while (target !== null)

            return target
        }

        this._getPosition = function(target) {
            var target = this._findTarget(target),
                left = this._measure(target, 'Left'),
                position = 'right';

            if (left > window.innerWidth * 0.75 && window.innerWidth > this.root.clientWidth) {
                position ='left';
            }

            return position;
        }.bind(this)

        this.cancelHideHandler = function() {
            this.timed.map(clearTimeout)
            this.timed = []
        }.bind(this)

        this._hide = function(immediate) {
            this.timed.push(setTimeout(function(){
                this.documentClickUnbinder();
                this.cancelHideHandler();
                this.root.classList.remove('show')
                this._sendToBack()
                this.trigger('hide');
            }.bind(this), immediate ? 1 : TRANSITION_TIMESPAN))
        }

        this.documentClickHandler = function(event) {
            this.cancelHideHandler();
            this.documentClickUnbinder();
            this._hide(true);
        }.bind(this)

        this.documentClickBinder = function() {
            document.addEventListener('click', this.documentClickHandler, true)
        }.bind(this)

        this.documentClickUnbinder = function() {
            document.removeEventListener('click', this.documentClickHandler, true)
        }.bind(this)

        this.hide = function() {
            this._hide(false)
        }.bind(this)

        this.on('show', function() {

        })

        this.show = function(event) {
            this.cancelHideHandler();

            var hideAction = event.target.__off || 'mouseout',
                showAction = event.target.__on || 'mouseover';

            this.root.removeEventListener('mouseout', this.hide, true)
            this.documentClickUnbinder()

            if (hideAction == 'mouseout')
                this.root.addEventListener('mouseout', this.hide, true)

            if (showAction == 'mouseover')

                this.root.addEventListener('click', this.documentClickHandler, true)
            else
                this.documentClickBinder()

            if (showAction == 'mouseover')
                this.root.addEventListener('click', this.documentClickHandler, true)

            if (showAction == 'focus') {
                event.target.addEventListener('click', this.cancelHideHandler, true)
                this.documentClickBinder()
            }

            this.childFocusableClick = function() {
                this.cancelHideHandler();
                this.documentClickBinder();
            }.bind(this)

            if (hideAction == 'blur') {
                var nodeList = this.root.querySelectorAll('input, select, textarea'),
                    inputs = Array.prototype.slice.call(nodeList, 0);

                this.root.removeEventListener('click', this.childFocusableClick, true);
                this.root.addEventListener('click', this.childFocusableClick, true);
                inputs.forEach(function(_input_) {
                    _input_.tabIndex = event.target.tabIndex;

                    _input_.removeEventListener('focus', this.cancelHideHandler, true);
                    _input_.removeEventListener('click', this.childFocusableClick, true);
                    _input_.addEventListener('click', this.childFocusableClick, true);
                    if (_input_.getAttribute('type') !== 'checkbox') {
                        _input_.addEventListener('focus', this.cancelHideHandler, true);
                    }
                }.bind(this))

                if (inputs.length > 0) {
                    inputs[inputs.length-1].addEventListener('keydown', function(_event_) {
                        _event_ = _event_ || window.event;
                        var key = _event_.which;
                        if (key == 9 && !_event_.shiftKey) {
                            event.target.focus()
                        }
                    })

                    inputs[0].addEventListener('keydown', function(_event_) {
                        _event_ = _event_ || window.event;
                        var key = _event_.which;
                        if (key == 9 && _event_.shiftKey) {
                            event.target.focus()
                            _event_.stopPropagation()
                            _event_.preventDefault()
                            return false;
                        }
                    })

                    event.target.addEventListener('keydown', function(_event_) {
                        _event_ = _event_ || window.event;
                        var key = _event_.which;
                        if (key == 9 && !_event_.shiftKey) {
                            inputs[0].focus()
                            _event_.stopPropagation()
                            _event_.preventDefault()
                            return false;
                        }
                    }.bind(this))
                }
            }

            this._showTip.call(this, event.target);
            this.trigger('show');
        }.bind(this)

        this.mouseover = function(event) {
            this.cancelHideHandler()
        }.bind(this)

        this._sendToBack = function() {
            this.cancelHideHandler()

            this.timed.push(setTimeout(function() {
                this.root.style.zIndex = -1;
                this.root.classList.remove('active')
                this.root.style.top = "-10000px";
            }.bind(this), TRANSITION_TIMESPAN))
        }

        this._initializeTriggers = function() {
            var nodeList = this.root.parentElement.querySelectorAll('*[data-menu="' + opts.name +'"]');
            this.triggers = Array.prototype.slice.call(nodeList, 0);
            this.triggers.forEach(function(el) {
                el.__on = el.getAttribute('data-menu-show') ? el.getAttribute('data-menu-show') : 'mouseover',
                el.__off = el.getAttribute('data-menu-hide') ? el.getAttribute('data-menu-hide') : 'mouseout';
                el.__tip_target = true;
                el.addEventListener('mouseover', this.cancelHideHandler, true)
                el.addEventListener(el.__on, this.show, true)
                if (el.__off !== 'click')
                    el.addEventListener(el.__off, this.hide, true)
            }.bind(this))
        }

});


riot.tag2('iconic-navigation', '<iconic-tip position="right" delay="1" name="navigation-tip" class="navigation-tip"></iconic-tip> <iconic-button class="icon-extra-small burger" name="menuButton" onclick="{expand}" hotkey="~`" data-menu="{opts.dataOverflow}"><i class="icon-burger"></i></iconic-button> <yield></yield>', 'iconic-navigation,[riot-tag="iconic-navigation"] { height: auto; margin: 0; overflow: hidden; padding: 0; position: relative; transition: all 200ms ease-in-out; width: 4.2rem; z-index: 2; } iconic-navigation.fixed-left,[riot-tag="iconic-navigation"].fixed-left { position: fixed; z-index: 3; bottom: 0rem; left: 0; right: auto; top: 0; } iconic-navigation.fixed-right,[riot-tag="iconic-navigation"].fixed-right { position: fixed; z-index: 3; bottom: 0rem; left: auto; right: 0; top: 0; } iconic-navigation .brand,[riot-tag="iconic-navigation"] .brand { display: block; position: absolute; margin-top: 0.8rem; margin-left:5.2rem; top:0; } iconic-navigation[class^="fixed"].expand .brand,[riot-tag="iconic-navigation"][class^="fixed"].expand .brand { display: block; margin-left:5.2rem; } iconic-navigation .brand i,[riot-tag="iconic-navigation"] .brand i { font-size: 1.8rem; vertical-align: middle; } iconic-navigation .brand span,[riot-tag="iconic-navigation"] .brand span { font-size: 1.2rem; font-weight: 300; line-height: 1rem; vertical-align: middle; } iconic-navigation .brand span b,[riot-tag="iconic-navigation"] .brand span b { font-weight: 700; } iconic-navigation iconic-button[name="menuButton"],[riot-tag="iconic-navigation"] iconic-button[name="menuButton"] { display: none; margin: 0.6rem; } iconic-navigation[class^="fixed"] iconic-button[name="menuButton"],[riot-tag="iconic-navigation"][class^="fixed"] iconic-button[name="menuButton"] { display: block; } iconic-navigation > ul,[riot-tag="iconic-navigation"] > ul { position: relative; bottom: 0rem; height: auto; left: 0; list-style: none; margin: 0; padding: 0; right: auto; top: 0rem; width: 4.2rem; overflow: hidden; white-space: nowrap; transition: all 200ms ease-in-out; } iconic-navigation:not([class^="fixed"]),[riot-tag="iconic-navigation"]:not([class^="fixed"]) { width: auto; } iconic-navigation:not([class^="fixed"]) ul,[riot-tag="iconic-navigation"]:not([class^="fixed"]) ul { width: auto; } iconic-navigation[class^="fixed"] > ul,[riot-tag="iconic-navigation"][class^="fixed"] > ul { top: 4.2rem; } iconic-navigation[class^="fixed"] > ul,[riot-tag="iconic-navigation"][class^="fixed"] > ul { position: absolute; } iconic-navigation.expand,[riot-tag="iconic-navigation"].expand { width: 25rem; } iconic-navigation.expand.slide,[riot-tag="iconic-navigation"].expand.slide { box-shadow: none; } iconic-navigation > ul li,[riot-tag="iconic-navigation"] > ul li { padding: 0; margin: 0; list-style: none; } iconic-navigation > ul li a,[riot-tag="iconic-navigation"] > ul li a { font-size: 2rem; text-align: left; display: block; padding: 0.4rem 0.5rem 0.5rem 0.5rem; transition: all 80ms ease-in-out; border-top: 1px solid white; text-decoration: none; vertical-align:middle; } iconic-navigation > ul > li > a > iconic-button,[riot-tag="iconic-navigation"] > ul > li > a > iconic-button { margin-right: 0.2rem; line-height: 0; } iconic-navigation > ul li ul,[riot-tag="iconic-navigation"] > ul li ul { padding: 0; margin: 0; } iconic-navigation > ul li ul li,[riot-tag="iconic-navigation"] > ul li ul li { padding: 0; margin: 0; list-style: none; } iconic-navigation > ul li ul li a,[riot-tag="iconic-navigation"] > ul li ul li a { font-size: 1rem; display: block; padding: 0.1rem 0.1rem 0.1rem 2rem; -webkit-transition: .5s all ease-out; -moz-transition: .5s all ease-out; transition: .5s all ease-out; text-decoration: none; } iconic-navigation.expand > ul,[riot-tag="iconic-navigation"].expand > ul { z-index: 500; width: 25rem; } @media (min-width: 750px) { iconic-navigation[class^="fixed"].auto .brand,[riot-tag="iconic-navigation"][class^="fixed"].auto .brand { margin-left: 1rem; } iconic-navigation[class^="fixed"].auto > .burger,[riot-tag="iconic-navigation"][class^="fixed"].auto > .burger { top: -4.2rem; } iconic-navigation.auto.expand,[riot-tag="iconic-navigation"].auto.expand { box-shadow: none; } iconic-navigation.auto,[riot-tag="iconic-navigation"].auto { width: 25rem; } iconic-navigation.auto > ul,[riot-tag="iconic-navigation"].auto > ul { top: 4.2rem; width: 25rem;} }', '', function(opts) {
        this.viewing = undefined;

        this._mapLinkToAnchor = function(element) {
            return this._elFromHref(element.href)
        }.bind(this)

        this._elFromHref = function(href) {
            return document.getElementById(this._hashFromHref(href))
        };

        this._hashFromHref = function(href) {
            return href.slice(href.indexOf('#') + 1)
        }

        this.getVisible = function(arrayOfElements, offset) {
            var visible = arrayOfElements[0];
            arrayOfElements.forEach(function(element) {
                if (element && element.offsetTop - 20 < offset) visible = element;
            });
            return visible;
        }.bind(this)

        this.on('update-visible-anchor', function(viewing) {
            this.viewing = viewing;

            this.links.forEach(function(element) {
                element.classList.remove('active');
                if (this.viewing && this.viewing.id === this._hashFromHref(element.href)) {
                    history.pushState(null, null, '#' + this.viewing.id);
                    element.classList.add('active');
                }
            }.bind(this))
        })

        this._scroll = function() {
            var visibleAnchor = this.getVisible(this.anchors, document.scrollTop || window.pageYOffset)
            if (this.viewing !== visibleAnchor) {
                this.trigger('update-visible-anchor', visibleAnchor)
            }
        }.bind(this)

        this.initializeReferences = function() {
            this.navigation = this.root.getElementsByTagName('UL')[0];
            if (this.navigation !== undefined) {
                this.links = Array.prototype.slice.call(this.navigation.getElementsByTagName('A'), 0);
                if (this.links.length > 0) {
                    if (!this.getFromHash()) {
                        this.links[0].classList.add('active');
                    }
                    this.anchors = this.links.map(this._mapLinkToAnchor);
                }
            }
        }

        this.initializeScrollListener = function() {
            if (this.anchors.length > 0) {
                window.addEventListener('scroll', this._scroll);
            }
        }

        this.on('mount', function() {
            if (opts.dataFixed) {
                this.root.classList.add("fixed-" + opts.dataFixed);
            }

            if (opts.dataEffect) {
                this.root.classList.add(opts.dataEffect);
            }

            this.tags['navigation-tip'].beforeShow = function() {
                var el = this.navigation.querySelector('li:hover'),
                    prop = el && el.textContent ? 'textContent' : 'innerText';

                if (this.navigation.clientWidth !== 42 || el === null || el[prop].trim().length === 0) {
                    return false;
                }
                this.tags['navigation-tip'].content.innerHTML = this.navigation.querySelector('li:hover').innerHTML
                return true;
            }.bind(this)

            this.initializeReferences()
            this.initializeScrollListener()
            this.tip = "iconic-navigation";
            var prop = this.tags['navigation-tip'].content.textContent ? 'textContent' : 'innerText';
            this.tags['navigation-tip'].content[prop] = this.tip;
            this.tags['navigation-tip'].update()

            setTimeout(function() {
                window.addEventListener('hashchange', this.getFromHash )
            }.bind(this), 0)
        })

        this.getFromHash = function() {
            var has = false;
            this.links.forEach(function(element) {
                element.classList.remove('active');
                if (window.location.hash.slice(1).match(new RegExp('^' + this._hashFromHref(element.href)))) {
                    element.classList.add('active');
                    has = true;
                }
            }.bind(this))
            return has;
        }.bind(this)

        this.cancelExpander = function() {
            this.root.classList.remove('expand');
            document.removeEventListener('click', this.cancelExpander);
        }.bind(this)

        this.expand = function() {
            document.removeEventListener('click', this.cancelExpander);
            if (this.root.classList.contains('expand')) {
                this.root.classList.remove('expand');
            } else {
                this.root.classList.add('expand');
                setTimeout(function() {
                    document.addEventListener('click', this.cancelExpander);
                }.bind(this), 0);
            }
        }.bind(this)
}, '{ }');


riot.tag2('iconic-tip', '<div name="left" class="arrow-left"></div> <div name="right" class="arrow-right"></div> <div name="up" class="arrow-up"></div> <div name="down" class="arrow-down"></div> <div name="content"> <yield></yield> </div>', 'iconic-tip,[riot-tag="iconic-tip"] { position: absolute; display: block; box-shadow: 0 0 0.8rem rgba(0, 0, 0, 0.6); background: #222; padding: 1rem; font-size: 1.5rem; border-radius: 0.3rem; color: #FFF; opacity: 0; margin: 0 auto; z-index: -1; transition: opacity 200ms ease-in-out; -webkit-user-select: none; -moz-user-select: none; -ms-user-select: none; user-select: none; pointer-events: none; } iconic-tip.navigation-tip,[riot-tag="iconic-tip"].navigation-tip { padding: 0.2rem 1rem 0.2rem 0.2rem; border-radius: 0.4rem; } iconic-tip.navigation-tip iconic-button,[riot-tag="iconic-tip"].navigation-tip iconic-button { vertical-align: middle; margin: 0; } iconic-tip.navigation-tip .arrow-right,[riot-tag="iconic-tip"].navigation-tip .arrow-right { top: 0.78rem; } iconic-tip.fixed,[riot-tag="iconic-tip"].fixed { position: fixed!important; } iconic-tip.active,[riot-tag="iconic-tip"].active { pointer-events: auto; } iconic-tip .content,[riot-tag="iconic-tip"] .content { padding: 0; margin: 0; } iconic-tip .arrow-up,[riot-tag="iconic-tip"] .arrow-up { position: absolute; width: auto; height: 0; border-left: 10px solid transparent; border-right: 10px solid transparent; border-bottom: 10px solid #222; margin: 0 auto; top: -10px; transition: opacity 200ms ease-in-out; } iconic-tip .arrow-down,[riot-tag="iconic-tip"] .arrow-down { position: absolute; width: 0; height: 0; border-left: 10px solid transparent; border-right: 10px solid transparent; border-top: 10px solid #222; bottom: -10px; margin: 0 auto; transition: opacity 200ms ease-in-out; } iconic-tip .arrow-left,[riot-tag="iconic-tip"] .arrow-left { position: absolute; width: 0; height: 0; border-top: 10px solid transparent; border-bottom: 10px solid transparent; border-left: 10px solid #222; right: -10px; transition: opacity 200ms ease-in-out; } iconic-tip .arrow-right,[riot-tag="iconic-tip"] .arrow-right { position: absolute; width: 0; height: 0; border-top: 10px solid transparent; border-bottom: 10px solid transparent; border-right: 10px solid #222; left: -10px; transition: opacity 200ms ease-in-out; } iconic-tip.active,[riot-tag="iconic-tip"].active { z-index: 9999; } iconic-tip.show,[riot-tag="iconic-tip"].show { opacity: 0.95; }', '', function(opts) {
        var TRANSITION_TIMESPAN = 200;
        this.timed = [];

        this.on('mount', function() {
            this.root.addEventListener('mouseover', this.clearTimed)
            this.root.addEventListener('mouseout', this.hide)
            this._initializeElements()
        })

        this.moveright = function(el) {
            this._showTip('right');
            this.left.style.top = "" + ((this.root.cleintHeight / 2) -  10) + "px";
            this.root.style.left = "" + (measure(el, 'Left') + el.clientWidth + 10) + "px";
            this.root.style.top = "" + (measure(el, 'Top')  - ((this.root.clientHeight / 2) - (el.clientHeight / 2))) + "px";
        }

        this.moveleft = function(el) {
            this._showTip('left');
            this.right.style.top = "" + ((this.root.clientHeight / 2) -  10) + "px";
            this.root.style.left = "" + (measure(el, 'Left') - this.root.clientWidth - 10) + "px";
            this.root.style.top = "" + (measure(el, 'Top')  - ((this.root.clientHeight / 2) - (el.clientHeight / 2))) + "px";
        }

        this.movebelow = function(el) {
            this._showTip('up');
            this.up.style.left = "" + ((this.root.clientWidth / 2) -  10) + "px";
            this.root.style.left = "" + ((measure(el, 'Left')  + (el.clientWidth / 2)) -  (this.root.clientWidth / 2)) + "px";
            this.root.style.top = "" + (measure(el, 'Top') + el.clientHeight + 10) + "px";
        }

        this.moveabove = function(el) {
            this._showTip('down');
            this.down.style.left = "" + ((this.root.clientWidth / 2) - 10) + "px";
            this.root.style.left = "" + ((measure(el, 'Left')  + (el.clientWidth / 2)) -  (this.root.clientWidth / 2)) + "px";
            this.root.style.top = "" + (measure(el, 'Top')  - this.root.clientHeight - 10) + "px";
        }

        var measure = function(el, attr, pixels) {
            if (pixels === undefined) { pixels = 0; }
            if (el == null) {
                return pixels;
            } else {
                pixels = pixels + (el['offset' + attr] - el['scroll' + attr]);
                return measure(el.offsetParent, attr, pixels);
            }
        }

        this.clearTimed = function() {
            this.timed.map(clearTimeout)
            this.timed = []
        }.bind(this)

        this.hide = function() {
            this.clearTimed()
            this.timed.push(setTimeout(function(){
                this.root.classList.remove('show')
                this._sendToBack()
            }.bind(this), TRANSITION_TIMESPAN))
        }.bind(this)

        this.on('show', function() {

        })

        this.show = function(event) {
            var proceed = true;
            if (this.beforeShow !== undefined) {
                proceed = this.beforeShow();
            }
            if (proceed) {
                this.clearTimed()
                this.timed.push(setTimeout(function() {
                    this.root.classList.add('fixed')
                    this['move' + (opts.position || 'right')].call(this, this._findTarget(event.target))
                    this.root.classList.add('active')
                    this.root.classList.add('show')
                }.bind(this), parseInt(opts.delay,10) || 1000))
            }
        }.bind(this)

        this._sendToBack = function() {
            this.clearTimed()

            this.timed.push(setTimeout(function() {
                this.root.classList.remove('active')
            }.bind(this), TRANSITION_TIMESPAN))
        }

        this._findTarget = function(target) {
            do {
                if (target._tip_target)
                    return target

                target = target.parentElement

            } while (target !== null)

            return target
        }

        this._initializeElements = function() {
            var elements = this.root.parentElement.querySelectorAll('*[data-tip="' + opts.name +'"]'),
                element;

            for(element = 0; element < elements.length; element++) {
                elements[element]._tip_target = true
                elements[element].addEventListener('mouseover', this.show)
                elements[element].addEventListener('mouseout', this.hide)
             }
        }

        this._showTip = function(name) {
            this.up.style.display = "none"
            this.left.style.display = "none"
            this.right.style.display = "none"
            this.down.style.display = "none"
            this[name].style.display = "block"
        }
});


riot.tag2('iconic-well', '<div name="well" class="u-well"> <yield></yield> </div>', 'iconic-well .u-well,[riot-tag="iconic-well"] .u-well { font-size: 0; min-width: 6rem; } iconic-well .u-well > *,[riot-tag="iconic-well"] .u-well > * { margin: 0.5rem 0.5rem 0.5rem 0; } iconic-well .u-well > *:first-child,[riot-tag="iconic-well"] .u-well > *:first-child { margin-left: 0.5rem; } iconic-well .u-well > *.wrapped,[riot-tag="iconic-well"] .u-well > *.wrapped { margin-left: 0.5rem; margin-right: 0.5rem; }', '', function(opts) {
        var MIN_USABLE_WIDTH = 100;

        function Style(element, original) {
            this.prop = {}
            this.element = element;
            this.isOriginal = original;

            if (original && element.__iconic_original_style === undefined) {
                this.prop = element.__iconic_original_style = {}
            } else if (original) {
                this.prop = element.__iconic_original_style
            }

            if (this.prop['all'] === undefined) {
                this._populate(element)
            }
        }

        Style.prototype._populate = function(element) {
            var styles = window.getComputedStyle(element)
            for (style in styles) {
                if (!parseInt(style, 10) && style != 0) {
                    this.prop[style] = styles[style]
                }
            }
            this.prop.iconicInnerWidth = "" + element.scrollWidth + "px"
        }

        Style.prototype.update = function() {
            if (this.isOriginal) {
                throw Error("Won't update an original");
            }
            this._populate(this.element);
        }

        Style.prototype.get = function() {
            return this.prop;
        }

        Style.prototype.asInt = function(name) {
            return parseInt(this.prop[name], 10);
        }

        Style.prototype.asFloat = function(name) {
            return parseFloat(this.prop[name]);
        }

        Style.prototype.asString = function(name) {
            return this.prop[name];
        }

        this.props = {
            paddingWidth: 10,
            offsetLeft: 0,
            offsetTop: 0
        }

        this.on('mount', function() {
            this.well.setAttribute('style', this.root.getAttribute('style'))
            this.root.removeAttribute('style')
            this.update()
            this.trigger('set-props')

            setTimeout(function() {
                window.addEventListener('resize', function() {
                    this.trigger('render')
                }.bind(this))
                this.trigger('render')
                this.update()
            }.bind(this), 0)
        })

        this.on('update', function() {
            this.trigger('render')
        })

        this.on('render', function() {
            var elements = Array.prototype.slice.call(this.well.children, 0)
            elements.forEach(this._renderElement)
        });

        this.on('set-props', function() {
            var style = new Style(this.well),
                paddingWidth = style.asFloat('paddingLeft') + style.asFloat('paddingRight'),
                elements = Array.prototype.slice.call(this.well.children, 0)
            this.props = {
                style: style,
                paddingWidth: paddingWidth,
                offsetLeft: elements[0].offsetLeft,
                offsetTop: elements[0].offsetTop
            }
        });

        this.getUsableWidth = function() {
            return this.well.clientWidth - this.props.paddingWidth
        }

        this._reset = function(element) {
            var originalStyle = new Style(element, true);
            element.style.fontSize = originalStyle.asString('fontSize')
            element.style.width = originalStyle.asString('width');
            element.style.paddingLeft = originalStyle.asString('paddingLeft');
            element.style.paddingRight = originalStyle.asString('paddingRight');
        }

        this._shouldWrap = function(element) {
            return element.offsetTop !== this.props.offsetTop && element.offsetLeft <= this.props.offsetLeft
        }

        this._renderWrapElement = function(element) {
            if (this._shouldWrap(element) || this.getUsableWidth() < MIN_USABLE_WIDTH) {
                element.classList.add('wrapped');
            } else {
                element.classList.remove('wrapped');
            }
        }

        this._shrinkToFit = function(element, style, fontSize) {
            while (element.scrollWidth > style.asFloat('width')) {
                fontSize = fontSize - 2;
                element.style.fontSize = "" + fontSize + "px";
                style.update();
            }
            return element;
        }

        this._renderElement = function(element) {
            var originalStyle = new Style(element, true),
                style = new Style(element),
                marginWidth = style.asFloat('marginLeft') + style.asFloat('marginRight'),
                usedWidth = originalStyle.asFloat('width') + marginWidth,
                usableWidth = this.getUsableWidth(),
                willCheckElementSize = this._shouldWrap(element) || usableWidth < MIN_USABLE_WIDTH

            if (willCheckElementSize) {
                if (usableWidth - usedWidth < 0 || usableWidth < MIN_USABLE_WIDTH) {
                    element.style.width = "" + (usableWidth - marginWidth) + "px"
                    element.style.paddingLeft = "0"
                    element.style.paddingRight = "0"
                    element = this._shrinkToFit(element, style, originalStyle.asFloat('fontSize'));
                } else {
                    this._reset(element)
                }
            } else {
                this._reset(element)
            }

            this._renderWrapElement(element)
        }.bind(this)
});


riot.tag2('iconic', '<yield></yield>', '', '', function(opts) {
        this.on('mount', function() {
            this.root.classList.remove('not-ready')
        })
});


        //END RIOT TAGS
    //
    //
}));
