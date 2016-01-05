function Module(exports, riot) {
    var _reference = [];

    //
    //
    // Am i a mixin?
    // riot.mixin('animation-context', { animation-context: library })

    //
    //
    //BEGIN RIOT TAGS
riot.tag2('demo', '<yield></yield>', '', '', function(opts) {
        this.on('mount', function() {
            this.root.className = '';
        })
});


riot.tag2('iconic-announcement', '<div class="loader"> <svg xmlns="http://www.w3.org/2000/svg" version="1.1" width="7rem" height="7rem" viewbox="0 0 500 500"> <path name="loader" transform="translate(250, 250) scale(4.2)"></path> </svg> </div> <iconic-button float="right" size="8" color="rgba(255,0,0,0.6)" onclick="{hide}">&times;</iconic-button> <div class="badge"> <i class="icon-announcement"></i> </div> <div class="content" onclick="{wait}"> <yield></yield> </div>', 'iconic-announcement,[riot-tag="iconic-announcement"] { display: block; position: fixed; top: -16rem; left: 0; right: 0; height: 8rem; transition: all 300ms ease-in-out; overflow: hidden; z-index: 200; } iconic-announcement.show,[riot-tag="iconic-announcement"].show { top: 0rem; } iconic-announcement .badge,[riot-tag="iconic-announcement"] .badge { padding: 1rem; position: relative; height: 6rem; width: 6rem; font-size: 6rem; line-height: 5rem; } iconic-announcement .content,[riot-tag="iconic-announcement"] .content { position: absolute; height: 6rem; top: 0rem; left: 8rem; width: auto; right: 8rem; font-size: 1.8rem; font-weight: bolder; padding:1rem; display: table-cell; vertical-align: middle; } iconic-announcement .loader,[riot-tag="iconic-announcement"] .loader { padding: 0.5rem; position: absolute; top: 0; right: 0; height: 7rem; width: 7rem; } iconic-announcement path[name="loader"],[riot-tag="iconic-announcement"] path[name="loader"] { fill: rgba(0, 0, 0, 0.5); }', '', function(opts) {
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

            console.log(angle, end);
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
            reset()
            clearTimeout(drawing)
            clearTimeout(showing)
            drawProgress();
            showing = setTimeout(function() {
                this.hide();
            }.bind(this), timeout || DEFAULT_TIMEOUT);
        }.bind(this)

        this.hide = function() {
            reset();
            clearTimeout(drawing)
            clearTimeout(showing)
            this.root.classList.remove('show')
        }.bind(this)

}, '{ }');


riot.tag2('iconic-button', '<div name="container" riot-style=" border-radius: {radius}rem; "> <div name="text" riot-style="height: {size}rem;"><yield></yield></div> <div name="hotkey" riot-style="height: {size}rem; width: {size}rem; border-radius: {radius}rem; ">{keyHelp[0]}</div> </div>', 'iconic-button,[riot-tag="iconic-button"] { display: block; position: relative; cursor: pointer; } iconic-button.inset,[riot-tag="iconic-button"].inset { border-radius: 0.4rem; } iconic-button.size-10,[riot-tag="iconic-button"].size-10 { height: 10rem; width: 10rem; font-size: 8rem; line-height: 8rem; border-radius: 1rem; } @-webkit-keyframes iconicButtonFlash { from { background: rgba(255,255,255, 0.5); } to { background: rgba(255,255,255, 0.3); } } @keyframes iconicButtonFlash { from { background: rgba(255,255,255, 0.5); } to { background: rgba(255,255,255, 0.3); } } iconic-button div[name="container"],[riot-tag="iconic-button"] div[name="container"] { background: rgba(255,255,255, 0); transition: all 400ms ease-in-out; transition-delay: 0ms; } iconic-button.inset div[name="container"],[riot-tag="iconic-button"].inset div[name="container"] { border-radius: 0.4rem; } iconic-button div[name="container"]:hover,[riot-tag="iconic-button"] div[name="container"]:hover { background: rgba(255,255,255, 0.3); } iconic-button div[name="container"]:active,[riot-tag="iconic-button"] div[name="container"]:active { -webkit-animation: iconicButtonFlash 200ms 1; -o-animation: iconicButtonFlash 200ms 1; animation: iconicButtonFlash 200ms 1; } iconic-button div[name="container"].activated,[riot-tag="iconic-button"] div[name="container"].activated { -webkit-animation: iconicButtonFlash 200ms 1; -o-animation: iconicButtonFlash 200ms 1; animation: iconicButtonFlash 200ms 1; } iconic-button div[name="text"],[riot-tag="iconic-button"] div[name="text"] { color: rgba(255,255,255,0.7); font-weight: bolder; text-align: center; vertical-align: center; transition: all 600ms ease-in-out; transition-delay: 0ms; -webkit-user-select: none; -moz-user-select: none; -ms-user-select: none; user-select: none; margin-top: 0%; font-size: 100%; } iconic-button div[name="hotkey"],[riot-tag="iconic-button"] div[name="hotkey"] { display: table-cell; opacity: 0; background: rgba(255,255,255,0.8); position: absolute; z-index: 5; top: 0; left: 0; color: rgba(0,0,0,0.4); font-weight: bolder; text-align: center; vertical-align: center; transition: all 200ms ease-in-out; transition-delay: 0ms; -webkit-user-select: none; -moz-user-select: none; -ms-user-select: none; user-select: none; margin-top: 0%; font-size: 100%; } iconic-button div[name="hotkey"].help,[riot-tag="iconic-button"] div[name="hotkey"].help { opacity: 1; } iconic-button div[name="text"] i,[riot-tag="iconic-button"] div[name="text"] i { margin-top: 22%; font-size: 75%; } iconic-button.inset div[name="text"] i,[riot-tag="iconic-button"].inset div[name="text"] i { margin-top: 20%; font-size: 69%; }', 'class="{inset: inset}" riot-style="background: {color}; float: {float}; height: {size}rem; width: {size}rem; line-height: {fontSize}rem; font-size: {fontSize}rem; border-radius: {radius}rem; margin: {margin}rem;"', function(opts) {
        var addEvent = window.document.addEventListener

        this.on('mount', function() {
            addEvent('keypress', function(event) {
                event = event || window.event;
                var key = event.which, name = event.target.nodeName.toUpperCase();
                if (key === 0 || event.target.contentEditable.toUpperCase() === "TRUE" || name === "TEXTAREA" ||
                    name === "INPUT" && event.target.type.toUpperCase() === "TEXT") { return true; }
                if (this.keyHelp && this.keyHelp.indexOf(String.fromCharCode(key)) > -1) {
                    this.activated = key;
                    return false;
                }
            }.bind(this))

            addEvent('keyup', function(event) {
                event = event || window.event;
                var key = event.which, name = event.target.nodeName.toUpperCase();
                if (key === 0 || event.target.contentEditable.toUpperCase() === "TRUE" || name === "TEXTAREA" ||
                    name === "INPUT" && event.target.type.toUpperCase() === "TEXT") { return true; }

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

            addEvent('keydown', function(event) {
                event = event || window.event;
                var key = event.which, name = event.target.nodeName.toUpperCase();
                if (key === 0 || event.target.contentEditable.toUpperCase() === "TRUE" || name === "TEXTAREA" ||
                    name === "INPUT" && event.target.type.toUpperCase() === "TEXT") { return true; }
                if (event.shiftKey && this.keyHelp) {
                    this.hotkey.classList.add('help')
                } else {
                    this.hotkey.classList.remove('help')
                }
                return true;
            }.bind(this));
        })

        this.on('mount update', function() {
            this.keyHelp = opts.hotkey || undefined;
            this.color = opts.color || 'transparent';
            this.float = opts.float || 'none';
            this.buttonSize = parseFloat(opts.size)|| 4;
            this.size = this.buttonSize;
            this.radius = 0;
            this.margin = 0;
            this.fontSize = parseFloat(this.buttonSize) * 0.8;
            this.inset = opts.inset !== undefined
            if (this.inset) {
                this.radius = '' + parseFloat(this.buttonSize) * 0.1;
                this.margin = '' + parseFloat(this.buttonSize) * 0.05;
                this.size = this.buttonSize * 0.9;
                this.fontSize = parseFloat(opts.size) * 0.74;
            }
        });
}, '{ }');


riot.tag2('iconic-navigation', '<iconic-button name="menuButton" size="4.2" color="#bbb" onclick="{expand}" hotkey="="><i class="fa fa-bars"></i></iconic-button> <yield></yield>', 'iconic-navigation,[riot-tag="iconic-navigation"] { display: block; position: relative; margin: 0; padding: 0; height: auto; width: 4.2rem; transition: all 200ms ease-in-out; overflow: hidden; } iconic-navigation.fixed-left,[riot-tag="iconic-navigation"].fixed-left { position: fixed; z-index: 1; bottom: 0rem; left: 0; right: auto; top: 0; } iconic-navigation.fixed-right,[riot-tag="iconic-navigation"].fixed-right { position: fixed; z-index: 1; bottom: 0rem; left: auto; right: 0; top: 0; } iconic-navigation iconic-button[name="menuButton"],[riot-tag="iconic-navigation"] iconic-button[name="menuButton"] { display: none; } iconic-navigation[class^="fixed"] iconic-button[name="menuButton"],[riot-tag="iconic-navigation"][class^="fixed"] iconic-button[name="menuButton"] { display: block; } iconic-navigation > ul,[riot-tag="iconic-navigation"] > ul { position: relative; bottom: 0rem; height: auto; left: 0; list-style: none; margin: 0; padding: 0; right: auto; top: 0rem; width: 4.2rem; overflow: hidden; white-space: nowrap; transition: all 200ms ease-in-out; } iconic-navigation:not([class^="fixed"]),[riot-tag="iconic-navigation"]:not([class^="fixed"]) { width: auto; } iconic-navigation:not([class^="fixed"]) ul,[riot-tag="iconic-navigation"]:not([class^="fixed"]) ul { width: auto; } iconic-navigation[class^="fixed"] > ul,[riot-tag="iconic-navigation"][class^="fixed"] > ul { top: 4.2rem; } iconic-navigation[class^="fixed"] > ul,[riot-tag="iconic-navigation"][class^="fixed"] > ul { position: absolute; } iconic-navigation.expand,[riot-tag="iconic-navigation"].expand { width: 25rem; box-shadow: 10px 0px 15px rgba(0,0,0,0.095); } iconic-navigation > ul li,[riot-tag="iconic-navigation"] > ul li { padding: 0; margin: 0; list-style: none; } iconic-navigation > ul li a,[riot-tag="iconic-navigation"] > ul li a { font-size: 2rem; text-align: left; display: block; padding: 0.5rem; transition: all 80ms ease-in-out; border-top: 1px solid white; text-decoration: none; } iconic-navigation > ul li:first-child a,[riot-tag="iconic-navigation"] > ul li:first-child a { border-top: none; } iconic-navigation > ul li ul,[riot-tag="iconic-navigation"] > ul li ul { padding: 0; margin: 0; } iconic-navigation > ul li ul li,[riot-tag="iconic-navigation"] > ul li ul li { padding: 0; margin: 0; list-style: none; } iconic-navigation > ul li ul li a,[riot-tag="iconic-navigation"] > ul li ul li a { font-size: 1rem; display: block; padding: 0.1rem 0.1rem 0.1rem 2rem; -webkit-transition: .5s all ease-out; -moz-transition: .5s all ease-out; transition: .5s all ease-out; border-top: 1px solid white; text-decoration: none; } iconic-navigation.expand > ul,[riot-tag="iconic-navigation"].expand > ul { z-index: 500; width: 25rem; } iconic-navigation.expand > ul,[riot-tag="iconic-navigation"].expand > ul { width: 25rem; z-index: 100; } @media (min-width: 750px) { iconic-navigation[class^="fixed"] > ul,[riot-tag="iconic-navigation"][class^="fixed"] > ul { top: 0rem; } iconic-navigation.expand,[riot-tag="iconic-navigation"].expand { box-shadow: none; } iconic-navigation,[riot-tag="iconic-navigation"] { width: 25rem; } iconic-navigation > ul,[riot-tag="iconic-navigation"] > ul { top: 0rem; width: 25rem; } }', '', function(opts) {
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
                    this.links[0].classList.add('active');
                    this.anchors = this.links.map(this._mapLinkToAnchor);
                }
            }
        }

        this.initializeScrollListener = function() {
            if (this.anchors.length > 0) {
                window.addEventListener('scroll', this._scroll);
                this._scroll()
            }
        }

        this.on('mount', function() {
            if (opts.dataFixed) {
                this.root.classList.add("fixed-" + opts.dataFixed);
            }
            this.initializeReferences()
            this.initializeScrollListener()
        })

        this.cancelExpander = function() {
            this.root.classList.remove('expand');
            document.removeEventListener('click', this.cancelExpander);
        }.bind(this)

        this.expand = function() {
            document.removeEventListener('click');
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


riot.tag2('iconic-tip', '<div name="left" class="arrow-left"></div> <div name="right" class="arrow-right"></div> <div name="up" class="arrow-up"></div> <div name="down" class="arrow-down"></div> <yield></yield>', 'iconic-tip,[riot-tag="iconic-tip"] { position: absolute; display: block; box-shadow: 0 0 1rem rgba(0, 0, 0, 0.8); background: #222; padding: 1rem; font-size: 1.5rem; border-radius: 0.3rem; color: #FFF; opacity: 0; margin: 0 auto; z-index: 500; } iconic-tip.animate,[riot-tag="iconic-tip"].animate { transition: opacity 200ms ease-in-out; } iconic-tip .arrow-up,[riot-tag="iconic-tip"] .arrow-up { position: absolute; width: auto; height: 0; border-left: 10px solid transparent; border-right: 10px solid transparent; border-bottom: 10px solid #222; margin: 0 auto; top: -10px; } iconic-tip .arrow-down,[riot-tag="iconic-tip"] .arrow-down { position: absolute; width: 0; height: 0; border-left: 10px solid transparent; border-right: 10px solid transparent; border-top: 10px solid #222; bottom: -10px; margin: 0 auto; } iconic-tip .arrow-left,[riot-tag="iconic-tip"] .arrow-left { position: absolute; width: 0; height: 0; border-top: 10px solid transparent; border-bottom: 10px solid transparent; border-left: 10px solid #222; right: -10px; } iconic-tip .arrow-right,[riot-tag="iconic-tip"] .arrow-right { position: absolute; width: 0; height: 0; border-top: 10px solid transparent; border-bottom: 10px solid transparent; border-right: 10px solid #222; left: -10px; } iconic-tip.show,[riot-tag="iconic-tip"].show { opacity: 0.95; }', '', function(opts) {

        this.showTip = function(name) {
            this.up.style.display = "none"
            this.left.style.display = "none"
            this.right.style.display = "none"
            this.down.style.display = "none"
            this[name].style.display = "block"
        }

        this.moveright = function(el) {
            setTimeout(function(){
                this.showTip('right');
                this.root.style.left = "" + (el.offsetLeft + el.clientWidth + 10) + "px";
                this.root.style.top = "" + (el.offsetTop  - ((this.root.clientHeight / 2) - (el.clientHeight / 2))) + "px";
            }.bind(this), 1);
        }

        this.moveleft = function(el) {
            setTimeout(function(){
                this.showTip('left');
                this.root.style.left = "" + (el.offsetLeft - this.root.clientWidth - 10) + "px";
                this.root.style.top = "" + (el.offsetTop  - ((this.root.clientHeight / 2) - (el.clientHeight / 2))) + "px";
                this.root.classList.add('animate')
            }.bind(this), 1);
        }

        this.movebelow = function(el) {
            setTimeout(function(){
                this.showTip('up');
                this.root.style.left = "" + ((el.offsetLeft + (el.clientWidth / 2)) -  (this.root.clientWidth / 2)) + "px";
                this.up.style.left = "" + ((this.root.clientWidth / 2) -  5) + "px";
                this.root.style.top = "" + (el.offsetTop + el.clientHeight + 10) + "px";
                this.root.classList.add('animate')
            }.bind(this), 1);
        }

        this.moveabove = function(el) {
            setTimeout(function(){
                this.showTip('down');
                this.root.style.left = "" + ((el.offsetLeft + (el.clientWidth / 2)) -  (this.root.clientWidth / 2)) + "px";
                this.down.style.left = "" + ((this.root.clientWidth / 2) -  5) + "px";
                this.root.style.top = "" + (el.offsetTop  - this.root.clientHeight - 10) + "px";
                this.root.classList.add('animate')
            }.bind(this), 1);
        }

        this.on('mount', function() {
            var tip = this.root,
                tfo, efo;

            var element = document.querySelector('button[data-tip="' + opts.name +'"]');
            this['move' + (opts.position || 'left')].call(this, element);

            this.root.onmouseover = function() {
                clearTimeout(efo);
                clearTimeout(tfo);
            }

            this.root.onmouseout = function() {
                tfo = setTimeout(function(){
                    this.root.classList.remove('show')
                    this.update();
                }.bind(this),300);
            }.bind(this)

            element.onmouseover = function() {
                clearTimeout(tfo);
                clearTimeout(efo);
                this['move' + (opts.position || 'left')].call(this, element);
                this.root.classList.add('show')
                this.update();
            }.bind(this)

            element.onmouseout = function() {
                efo = setTimeout(function(){
                    this.root.classList.remove('show')
                    this.update();
                }.bind(this),300);
            }.bind(this)

            this.root.classList.add('animate')
        })
});


        //END RIOT TAGS
    //
    //
}

Module.prototype.dependencies = ['riot', 'riot-i18n', 'classlist-polyfill']
Module.prototype.global = "anycode-components";

// Module UMD Loader
(function (g, f) {
    var d=Module.prototype.dependencies,gn=Module.prototype.global
    if (typeof define==='function'&&define.amd){define(['exports'].concat(d||[]),f)}else if(typeof exports==='object'&&
        typeof exports.nodeName!=='string'){f.apply(this,[exports].concat(d?d.map(require):[]))}else{if(typeof gn==='string'
    )gn=[gn];g[gn[0]]={};gn.splice(1).map(function(d){g[d]=g[gn[0]]});f.apply(this, [g[gn[0]]].concat(d?d.map(function(d
    ){return g[d]}):[]))}
}(this, Module));
