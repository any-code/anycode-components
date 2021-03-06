<iconic-navigation>

    <iconic-tip position="right" delay="1" name="navigation-tip" class="navigation-tip"></iconic-tip>
    <iconic-button class="icon-extra-small burger" name="menuButton" onclick="{ expand }" hotkey="~`" data-menu="{ opts.dataOverflow }"><i class="icon-burger"></i></iconic-button>
    <yield/>

    <script>

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
                    this.initializeScrollListener()
                }
            }
        }

        this.initializeScrollListener = function() {
            if (this.anchors && this.anchors.length > 0) {
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
            this.tip = "iconic-navigation";
            var prop = this.tags['navigation-tip'].content.textContent ? 'textContent' : 'innerText';
            this.tags['navigation-tip'].content[prop] = this.tip;
            this.tags['navigation-tip'].update()

            ;(function(ctx) {
                document.body.classList.add('navigation-margin')
                window.addEventListener('hashchange', ctx.getFromHash )
            })(this)
        })

        this.on('unmount', function() { document.body.classList.remove('navigation-margin') })

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
    </script>

    <style scoped>
        :scope { height: auto; margin: 0; overflow: hidden; padding: 0; position: relative;
            transition: all 200ms ease-in-out; width: 4.2rem; z-index: 2; }
        :scope.fixed-left { position: fixed; z-index: 3; bottom: 0rem; left: 0; right: auto; top: 0; }
        :scope.fixed-right { position: fixed; z-index: 3; bottom: 0rem; left: auto; right: 0; top: 0; }
        :scope .brand { display: block; position: absolute; margin-top: 0.8rem; margin-left:5.2rem; top:0; }
        :scope[class^="fixed"].expand .brand { display: block; margin-left:5.2rem; }
        :scope .brand i { font-size: 1.8rem; vertical-align: middle; }
        :scope .brand span { font-size: 1.2rem; font-weight: 300; line-height: 1rem; vertical-align: middle; }
        :scope .brand span b { font-weight: 700; }
        iconic-button[name="menuButton"] { display: none; margin: 0.6rem; }
        :scope[class^="fixed"] iconic-button[name="menuButton"] { display: block; }
        :scope > ul { position: relative; bottom: 0rem; height: auto; left: 0; list-style: none; margin: 0; padding: 0;
            right: auto; top: 0rem; width: 4.2rem; overflow: hidden; white-space: nowrap;
            transition: all 200ms ease-in-out; }
        :scope:not([class^="fixed"]) { width: auto; }
        :scope:not([class^="fixed"]) ul { width: auto; }
        :scope[class^="fixed"] > ul { top: 4.2rem; }
        :scope[class^="fixed"] > ul { position: absolute; }
        :scope.expand { width: 25rem; }
        :scope.expand.slide { box-shadow: none; }
        :scope > ul li { padding: 0; margin: 0; list-style: none; }
        :scope > ul li a { font-size: 2rem; text-align: left; display: block; padding: 0.4rem 0.5rem 0.5rem 0.5rem;
            transition: all 80ms ease-in-out; border-top: 1px solid white; text-decoration: none; vertical-align:middle; }
        :scope > ul > li > a > iconic-button { margin-right: 0.2rem; line-height: 0; }
        :scope > ul li ul { padding: 0; margin: 0; }
        :scope > ul li ul li { padding: 0; margin: 0; list-style: none; }
        :scope > ul li ul li a { font-size: 1rem; display: block; padding: 0.1rem 0.1rem 0.1rem 2rem;
            -webkit-transition: .5s all ease-out; -moz-transition: .5s all ease-out;
            transition: .5s all ease-out; text-decoration: none; }
        :scope.expand > ul { z-index: 500; width: 25rem; }
        @media (min-width: 750px) {
            :scope[class^="fixed"].auto .brand { margin-left: 1rem; }
            :scope[class^="fixed"].auto > .burger { top: -4.2rem; }
            :scope.auto.expand { box-shadow: none; }
            :scope.auto { width: 25rem; }
            :scope.auto > ul { top: 4.2rem; width: 25rem;}
        }
    </style>
</iconic-navigation>
