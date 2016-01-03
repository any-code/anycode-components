/*
        anycode-components
 */

(function(def){
    def(['riot'], function(riot) {

        function Library() {
            this.name = "anycode-components"
        }

        var library = new Library()

        //
        //
        // Am i a mixin?
        // riot.mixin('anycode-components', { anycode-components: library })

        //
        //
        //BEGIN RIOT TAGS
riot.tag2('demo', '<yield></yield>', '', '', function(opts) {
        this.on('mount', function() {
            this.root.className = '';
        })
});


riot.tag2('iconic-button', '<div name="container" riot-style=" border-radius: {radius}rem; "> <div name="text" riot-style="height: {size}rem;"><yield></yield></div> <div name="hotkey" riot-style="height: {size}rem; width: {size}rem; border-radius: {radius}rem; ">{keyHelp}</div> </div>', 'iconic-button,[riot-tag="iconic-button"] { display: block; position: relative; cursor: pointer; } iconic-button.inset,[riot-tag="iconic-button"].inset { border-radius: 0.4rem; } iconic-button.size-10,[riot-tag="iconic-button"].size-10 { height: 10rem; width: 10rem; font-size: 8rem; line-height: 8rem; border-radius: 1rem; } @-webkit-keyframes iconicButtonFlash { from { background: rgba(255,255,255, 0.5); } to { background: rgba(255,255,255, 0.3); } } @keyframes iconicButtonFlash { from { background: rgba(255,255,255, 0.5); } to { background: rgba(255,255,255, 0.3); } } iconic-button div[name="container"],[riot-tag="iconic-button"] div[name="container"] { background: rgba(255,255,255, 0); transition: all 400ms ease-in-out; transition-delay: 0ms; } iconic-button.inset div[name="container"],[riot-tag="iconic-button"].inset div[name="container"] { border-radius: 0.4rem; } iconic-button div[name="container"]:hover,[riot-tag="iconic-button"] div[name="container"]:hover { background: rgba(255,255,255, 0.3); } iconic-button div[name="container"]:active,[riot-tag="iconic-button"] div[name="container"]:active { -webkit-animation: iconicButtonFlash 200ms 1; -o-animation: iconicButtonFlash 200ms 1; animation: iconicButtonFlash 200ms 1; } iconic-button div[name="container"].activated,[riot-tag="iconic-button"] div[name="container"].activated { -webkit-animation: iconicButtonFlash 200ms 1; -o-animation: iconicButtonFlash 200ms 1; animation: iconicButtonFlash 200ms 1; } iconic-button div[name="text"],[riot-tag="iconic-button"] div[name="text"] { color: rgba(255,255,255,0.7); font-weight: bolder; text-align: center; vertical-align: center; transition: all 600ms ease-in-out; transition-delay: 0ms; -webkit-user-select: none; -moz-user-select: none; -ms-user-select: none; user-select: none; margin-top: 0%; font-size: 100%; } iconic-button div[name="hotkey"],[riot-tag="iconic-button"] div[name="hotkey"] { display: table-cell; opacity: 0; background: rgba(255,255,255,0.8); position: absolute; z-index: 5; top: 0; left: 0; color: rgba(0,0,0,0.4); font-weight: bolder; text-align: center; vertical-align: center; transition: all 200ms ease-in-out; transition-delay: 0ms; -webkit-user-select: none; -moz-user-select: none; -ms-user-select: none; user-select: none; margin-top: 0%; font-size: 100%; } iconic-button div[name="hotkey"].help,[riot-tag="iconic-button"] div[name="hotkey"].help { opacity: 1; } iconic-button div[name="text"] i,[riot-tag="iconic-button"] div[name="text"] i { margin-top: 22%; font-size: 75%; } iconic-button.inset div[name="text"] i,[riot-tag="iconic-button"].inset div[name="text"] i { margin-top: 20%; font-size: 69%; }', 'class="{inset: inset}" riot-style="background: {color}; float: {float}; height: {size}rem; width: {size}rem; line-height: {fontSize}rem; font-size: {fontSize}rem; border-radius: {radius}rem; margin: {margin}rem;"', function(opts) {
        var addEvent = window.document.addEventListener
        this.initializeHotKey = function() {
            if (!opts.hotkey) {
                return undefined;
            }

            return opts.hotkey.length == 1 ? opts.hotkey.toUpperCase().charCodeAt(0) : parseInt(opts.hotkey, 10)
        }

        this.size = parseFloat(opts.size)|| 4;
        this.fontSize = parseFloat(opts.size) * 0.8;
        this.inset = false;

        this.on('mount', function() {
            addEvent('keyup', function(event) {
                event = event || window.event;

                var key = event.which, name = event.target.nodeName.toUpperCase();
                if (key === 0 || event.target.contentEditable.toUpperCase() === "TRUE" || name === "TEXTAREA" || name === "INPUT" && event.target.type.toUpperCase() === "TEXT") { return true; }

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

            console.log("MOUNT AND ADD KEYDOWN")
            addEvent('keydown', function(event) {
                console.log("KD!!!!", event)
                event = event || window.event;
                var key = event.which, name = event.target.nodeName.toUpperCase();
                if (key === 0 || event.target.contentEditable.toUpperCase() === "TRUE" || name === "TEXTAREA" || name === "INPUT" && event.target.type.toUpperCase() === "TEXT") { return true; }

                console.log(event);

                if (event.shiftKey) {
                    if (this.keyCode) {
                        this.hotkey.classList.add('help')
                    }
                } else {
                    this.hotkey.classList.remove('help')
                }

                if (key === this.keyCode) {
                    this.activated = true;
                    return false;
                }

                return true;
            }.bind(this));
        })

        this.on('mount update', function() {
            this.keyCode = this.initializeHotKey();
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


riot.tag2('iconic-navigation', '<yield></yield>', 'iconic-navigation,[riot-tag="iconic-navigation"] { display: block; position: relative; margin: 0; padding: 0; width: 25rem; height: auto; } iconic-navigation.fixed-left,[riot-tag="iconic-navigation"].fixed-left { position: fixed; z-index: 1; bottom: 0rem; left: 0; right: auto; top: 0; } iconic-navigation.fixed-right,[riot-tag="iconic-navigation"].fixed-right { position: fixed; z-index: 1; bottom: 0rem; left: auto; right: 0; top: 0; } iconic-navigation > ul,[riot-tag="iconic-navigation"] > ul { position: relative; background: #D6FFF7; bottom: 0rem; height: auto; left: 0; list-style: none; margin: 0; padding: 0; right: auto; top: 0; width: 25rem; } iconic-navigation.fixed-left > ul,[riot-tag="iconic-navigation"].fixed-left > ul { position: absolute; } iconic-navigation > ul li,[riot-tag="iconic-navigation"] > ul li { padding: 0; margin: 0; list-style: none; } iconic-navigation > ul li:first-child a,[riot-tag="iconic-navigation"] > ul li:first-child a { border-top: none; } iconic-navigation > ul li a,[riot-tag="iconic-navigation"] > ul li a { font-size: 2rem; text-align: left; display: block; padding: 0.5rem; -webkit-transition: .5s all ease-out; -moz-transition: .5s all ease-out; transition: .5s all ease-out; border-top: 1px solid white; color: #999; text-decoration: none; } iconic-navigation > ul li:first-child a,[riot-tag="iconic-navigation"] > ul li:first-child a { border-top: none; } iconic-navigation > ul li ul,[riot-tag="iconic-navigation"] > ul li ul { padding: 0; margin: 0; } iconic-navigation > ul li ul li,[riot-tag="iconic-navigation"] > ul li ul li { padding: 0; margin: 0; list-style: none; } iconic-navigation > ul li ul li a,[riot-tag="iconic-navigation"] > ul li ul li a { font-size: 1rem; display: block; padding: 0.1rem 0.1rem 0.1rem 2rem; -webkit-transition: .5s all ease-out; -moz-transition: .5s all ease-out; transition: .5s all ease-out; border-top: 1px solid white; color: #aaa; text-decoration: none; } iconic-navigation > ul a:hover,[riot-tag="iconic-navigation"] > ul a:hover { color: #000; } iconic-navigation > ul .active,[riot-tag="iconic-navigation"] > ul .active { background: #00d4b4; color: #FFF; }', '', function(opts) {
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
});


        //END RIOT TAGS
        //
        //

        return library;

    });
}( (function(darr, name){
    if (typeof require === 'undefined') {
        return function (deps, factory) { this[name] = factory.apply(this, darr.map(function(arg) { return window[arg] })); }
    } else if (typeof exports === 'undefined') {
        return function (deps, factory) { define(name, deps, factory); }
    } else {
        require('riot'); // must find a solution to why require needs to be called with primitive
        return function (deps, factory) { module.exports = factory.apply(this, deps.map(require)); }
    }
})(['riot'], 'anycode-components') ));
