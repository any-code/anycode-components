<iconic-navigation>
    <yield/>
    <style scoped>

        :scope {
            display: block;
            position: relative;
            margin: 0;
            padding: 0;
            width: 25rem;
            height: auto;
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
            top: 0;
            width: 25rem;
        }

        :scope.fixed-left > ul {
            position: absolute;
        }

        :scope > ul li {
            padding: 0;
            margin: 0;
            list-style: none;
        }


        :scope > ul li:first-child a {
            border-top: none;
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
    </script>
</iconic-navigation>
