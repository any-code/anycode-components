<iconic-navigation>
    <iconic-button size="4.2" color="#bbb" onclick="{ expand }"><i class="fa fa-bars"></i></iconic-button>

    <yield/>
    <style scoped>
        :scope {
            display: block;
            position: relative;
            margin: 0;
            padding: 0;
            height: auto;
            background: #D6FFF7;
        }

        :scope.fixed-left {
            position: fixed;
            z-index: 1;
            bottom: 0rem;
            left: 0;
            right: auto;
            top: 0;
        }

        :scope.fixed-right {
            position: fixed;
            z-index: 1;
            bottom: 0rem;
            left: auto;
            right: 0;
            top: 0;
        }

        :scope > ul {
            position: relative;
            background: #D6FFF7;
            bottom: 0rem;
            height: auto;
            left: 0;
            list-style: none;
            margin: 0;
            padding: 0;
            right: auto;
            top: 4.2rem;
            width: 4.2rem;
            overflow: hidden;
            white-space: nowrap;
            transition: all 200ms ease-in-out;
        }

        :scope.fixed-left > ul {
            position: absolute;
        }

        :scope > ul li {
            padding: 0;
            margin: 0;
            list-style: none;
        }


        :scope > ul li a {
            font-size: 2rem;
            text-align: left;
            display: block;
            padding: 0.5rem;
            -webkit-transition: .5s all ease-out;
            -moz-transition: .5s all ease-out;
            transition: .5s all ease-out;
            border-top: 1px solid white;
            color: #999;
            text-decoration: none;
        }

        :scope > ul li:first-child a {
            border-top: none;
        }

        :scope > ul li ul {
            padding: 0;
            margin: 0;
        }

        :scope > ul li ul li {
            padding: 0;
            margin: 0;
            list-style: none;
        }

        :scope > ul li ul li a {
            font-size: 1rem;
            display: block;
            padding: 0.1rem 0.1rem 0.1rem 2rem;
            -webkit-transition: .5s all ease-out;
            -moz-transition: .5s all ease-out;
            transition: .5s all ease-out;
            border-top: 1px solid white;
            color: #aaa;
            text-decoration: none;
        }

        :scope > ul a:hover {
            color: #000;
        }

        :scope > ul .active {
            background: #00d4b4;
            color: #FFF;
        }

        :scope > ul.expand {
            z-index: 500;
            width: 25rem;
        }


        :scope > ul.expand {
            background: #D6FFF7;
            width: 25rem;
            box-shadow: 10px 5px 10px rgba(0,0,0,0.2);
            z-index: 100;
        }

        @media (min-width: 750px) {
            :scope > ul {
                top: 0rem;
                width: 25rem;
            }
        }
    </style>
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
    </script>
</iconic-navigation>
