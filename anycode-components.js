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


riot.tag2('iconic-button', '<div name="container" riot-style=" border-radius: {radius}rem; "> <div name="text" riot-style="height: {size}rem;"><yield></yield></div> <div name="hotkey" riot-style="height: {size}rem; width: {size}rem; border-radius: {radius}rem; ">{keyHelp}</div> </div>', 'iconic-button,[riot-tag="iconic-button"] { display: block; position: relative; cursor: pointer; } iconic-button.inset,[riot-tag="iconic-button"].inset { border-radius: 0.4rem; } iconic-button.size-10,[riot-tag="iconic-button"].size-10 { height: 10rem; width: 10rem; font-size: 8rem; line-height: 8rem; border-radius: 1rem; } @-webkit-keyframes iconicButtonFlash { from { background: rgba(255,255,255, 0.5); } to { background: rgba(255,255,255, 0.3); } } @keyframes iconicButtonFlash { from { background: rgba(255,255,255, 0.5); } to { background: rgba(255,255,255, 0.3); } } iconic-button div[name="container"],[riot-tag="iconic-button"] div[name="container"] { background: rgba(255,255,255, 0); transition: all 400ms ease-in-out; transition-delay: 0ms; } iconic-button.inset div[name="container"],[riot-tag="iconic-button"].inset div[name="container"] { border-radius: 0.4rem; } iconic-button div[name="container"]:hover,[riot-tag="iconic-button"] div[name="container"]:hover { background: rgba(255,255,255, 0.3); } iconic-button div[name="container"]:active,[riot-tag="iconic-button"] div[name="container"]:active { -webkit-animation: iconicButtonFlash 200ms 1; -o-animation: iconicButtonFlash 200ms 1; animation: iconicButtonFlash 200ms 1; } iconic-button div[name="container"].activated,[riot-tag="iconic-button"] div[name="container"].activated { -webkit-animation: iconicButtonFlash 200ms 1; -o-animation: iconicButtonFlash 200ms 1; animation: iconicButtonFlash 200ms 1; } iconic-button div[name="text"],[riot-tag="iconic-button"] div[name="text"] { color: rgba(255,255,255,0.7); font-weight: bolder; text-align: center; vertical-align: center; transition: all 600ms ease-in-out; transition-delay: 0ms; -webkit-user-select: none; -moz-user-select: none; -ms-user-select: none; user-select: none; margin-top: 0%; font-size: 100%; } iconic-button div[name="hotkey"],[riot-tag="iconic-button"] div[name="hotkey"] { display: table-cell; opacity: 0; background: rgba(255,255,255,0.8); position: absolute; z-index: 5; top: 0; left: 0; color: rgba(0,0,0,0.4); font-weight: bolder; text-align: center; vertical-align: center; transition: all 200ms ease-in-out; transition-delay: 0ms; -webkit-user-select: none; -moz-user-select: none; -ms-user-select: none; user-select: none; margin-top: 0%; font-size: 100%; } iconic-button div[name="hotkey"].help,[riot-tag="iconic-button"] div[name="hotkey"].help { opacity: 1; } iconic-button div[name="text"] i,[riot-tag="iconic-button"] div[name="text"] i { margin-top: 22%; font-size: 75%; } iconic-button.inset div[name="text"] i,[riot-tag="iconic-button"].inset div[name="text"] i { margin-top: 20%; font-size: 69%; }', 'class="{inset: inset}" riot-style="background: {color}; float: {float}; height: {size}rem; width: {size}rem; line-height: {fontSize}rem; font-size: {fontSize}rem; border-radius: {radius}rem; margin: {margin}rem;"', function(opts) {
        var addEvent = window.document.addEventListener

        this.size = parseFloat(opts.size)|| 4;
        this.fontSize = parseFloat(opts.size) * 0.8;
        this.inset = false;

        this.on('mount', function() {
            addEvent('keypress', function(event) {
                var key = event.which, name = event.target.nodeName.toUpperCase();
                if (key === 0 || event.target.contentEditable.toUpperCase() === "TRUE" || name === "TEXTAREA" || name === "INPUT" && event.target.type.toUpperCase() === "TEXT") { return true; }

                var otherKey = key - 32;
                if (key >= 65 && key <= 90) {
                    otherKey = key + 32;
                }

                if (String.fromCharCode(key) === this.keyHelp || String.fromCharCode(otherKey) === this.keyHelp) {
                    this.activated = key;
                    return false;
                }

            }.bind(this))

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

            addEvent('keydown', function(event) {

                event = event || window.event;
                var key = event.which, name = event.target.nodeName.toUpperCase();
                if (key === 0 || event.target.contentEditable.toUpperCase() === "TRUE" || name === "TEXTAREA" || name === "INPUT" && event.target.type.toUpperCase() === "TEXT") { return true; }

                if (event.shiftKey) {
                    if (this.keyHelp) {
                        this.hotkey.classList.add('help')
                    }
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


riot.tag2('iconic-code', '<pre name="preCodeBox" class="language-markup"><code class="language-markup" name="codeBox"></code></pre> <pre name="raw" if="{false}"><yield></yield></pre>', 'iconic-code pre[name="raw"],[riot-tag="iconic-code"] pre[name="raw"] { display: none; }', '', function(opts) {

        this.on('mount', function() {
            this.spacesPerTab = opts.spacesPerTab || 4;

            if (opts.language) {
                this.preCodeBox.className = 'language-' + opts.language;
                this.codeBox.className = 'language-' + opts.language;
            }

            this.codeBox.innerHTML = this.raw.innerHTML
                .trim()
                .replace(/&/g, '&amp;')
                .replace(/</g, '&lt;')
                .replace(/>/g, '&gt;')
                .replace(/"/g, '&quot;')

            if (opts.untab && parseInt(opts.untab, 10) > 0) {
                var utr = new RegExp("\n(( {" + this.spacesPerTab + "}){" + opts.untab + "}|\t{" + opts.untab + "})", "g");
                this.codeBox.innerHTML = this.codeBox.innerHTML.replace(utr, "\n");
            }

        });
}, '{ }');


riot.tag2('iconic-navigation', '<iconic-button size="4.2" color="#bbb" onclick="{expand}" hotkey="="><i class="fa fa-bars"></i></iconic-button> <yield></yield>', 'iconic-navigation,[riot-tag="iconic-navigation"] { display: block; position: relative; margin: 0; padding: 0; height: auto; background: #D6FFF7; } iconic-navigation.fixed-left,[riot-tag="iconic-navigation"].fixed-left { position: fixed; z-index: 1; bottom: 0rem; left: 0; right: auto; top: 0; } iconic-navigation.fixed-right,[riot-tag="iconic-navigation"].fixed-right { position: fixed; z-index: 1; bottom: 0rem; left: auto; right: 0; top: 0; } iconic-navigation > ul,[riot-tag="iconic-navigation"] > ul { position: relative; background: #D6FFF7; bottom: 0rem; height: auto; left: 0; list-style: none; margin: 0; padding: 0; right: auto; top: 4.2rem; width: 4.2rem; overflow: hidden; white-space: nowrap; transition: all 200ms ease-in-out; } iconic-navigation.fixed-left > ul,[riot-tag="iconic-navigation"].fixed-left > ul { position: absolute; } iconic-navigation > ul li,[riot-tag="iconic-navigation"] > ul li { padding: 0; margin: 0; list-style: none; } iconic-navigation > ul li a,[riot-tag="iconic-navigation"] > ul li a { font-size: 2rem; text-align: left; display: block; padding: 0.5rem; -webkit-transition: .5s all ease-out; -moz-transition: .5s all ease-out; transition: .5s all ease-out; border-top: 1px solid white; color: #999; text-decoration: none; } iconic-navigation > ul li:first-child a,[riot-tag="iconic-navigation"] > ul li:first-child a { border-top: none; } iconic-navigation > ul li ul,[riot-tag="iconic-navigation"] > ul li ul { padding: 0; margin: 0; } iconic-navigation > ul li ul li,[riot-tag="iconic-navigation"] > ul li ul li { padding: 0; margin: 0; list-style: none; } iconic-navigation > ul li ul li a,[riot-tag="iconic-navigation"] > ul li ul li a { font-size: 1rem; display: block; padding: 0.1rem 0.1rem 0.1rem 2rem; -webkit-transition: .5s all ease-out; -moz-transition: .5s all ease-out; transition: .5s all ease-out; border-top: 1px solid white; color: #aaa; text-decoration: none; } iconic-navigation > ul a:hover,[riot-tag="iconic-navigation"] > ul a:hover { color: #000; } iconic-navigation > ul .active,[riot-tag="iconic-navigation"] > ul .active { background: #00d4b4; color: #FFF; } iconic-navigation > ul.expand,[riot-tag="iconic-navigation"] > ul.expand { z-index: 500; width: 25rem; } iconic-navigation > ul.expand,[riot-tag="iconic-navigation"] > ul.expand { background: #D6FFF7; width: 25rem; box-shadow: 10px 0px 15px rgba(0,0,0,0.095); z-index: 100; } @media (min-width: 750px) { iconic-navigation > ul,[riot-tag="iconic-navigation"] > ul { top: 0rem; width: 25rem; } iconic-navigation > ul.expand,[riot-tag="iconic-navigation"] > ul.expand { box-shadow: none; } }', '', function(opts) {
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
            this.navigation.classList.remove('expand');
            document.removeEventListener('click', this.cancelExpander);
        }.bind(this)

        this.expand = function() {
            document.removeEventListener('click');
            if (this.navigation.classList.contains('expand')) {
                this.navigation.classList.remove('expand');
            } else {
                this.navigation.classList.add('expand');
                setTimeout(function() {
                    document.addEventListener('click', this.cancelExpander);
                }.bind(this), 0);

            }

        }.bind(this)
}, '{ }');


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
