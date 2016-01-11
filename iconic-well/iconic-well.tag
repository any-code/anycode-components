<iconic-well>
    <div name="well" class="u-well">
        <yield/>
    </div>
    <style scoped>
        .u-well { font-size: 0; min-width: 6rem; }
        .u-well > * { margin: 0.5rem 0.5rem 0.5rem 0; }
        .u-well > *:first-child { margin-left: 0.5rem; }
        .u-well > *.wrapped { margin-left: 0.5rem; margin-right: 0.5rem; }
    </style>
    <script>
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

        this.on('mount', function() {
            this.well.setAttribute('style', this.root.getAttribute('style'))
            this.root.removeAttribute('style')
            this.update()
            this.trigger('set-props')

            window.addEventListener('resize', function() {
                this.trigger('render')
            }.bind(this))
            setTimeout(function() {
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
            if (this._shouldWrap(element) || this.getBurstWidth() < MIN_USABLE_WIDTH) {
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
    </script>
</iconic-well>
