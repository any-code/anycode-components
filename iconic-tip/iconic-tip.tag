<iconic-tip>
    <div name="left" class="arrow-left"></div>
    <div name="right"  class="arrow-right"></div>
    <div name="up" class="arrow-up"></div>
    <div name="down" class="arrow-down"></div>
    <div name="content">
        <yield/>
    </div>
    <style scoped>
        :scope {
            position: absolute;
            display: block;
            box-shadow: 0 0 1rem rgba(0, 0, 0, 0.8);
            background: #222;
            padding: 1rem;
            font-size: 1.5rem;
            border-radius: 0.3rem;
            color: #FFF;
            opacity: 0;
            margin: 0 auto;
            z-index: -1;
            transition: opacity 200ms ease-in-out;
        }

        :scope.navigation-tip {
            padding: 0.2rem 1rem 0.2rem 0.2rem;
            border-radius: 0.4rem;
        }

        :scope.navigation-tip .arrow-right {
            top: 0.78rem;
        }

        :scope.fixed {
            position: fixed!important;
        }

        .content {
            padding: 0;
            margin: 0;
        }


        .arrow-up {
            position: absolute;
            width: auto;
            height: 0;
            border-left: 10px solid transparent;
            border-right: 10px solid transparent;
            border-bottom: 10px solid #222;
            margin: 0 auto;
            top: -10px;
        }

        .arrow-down {
            position: absolute;
            width: 0;
            height: 0;
            border-left: 10px solid transparent;
            border-right: 10px solid transparent;
            border-top: 10px solid #222;
            bottom: -10px;
            margin: 0 auto;
        }

        .arrow-left {
            position: absolute;
            width: 0;
            height: 0;
            border-top: 10px solid transparent;
            border-bottom: 10px solid transparent;
            border-left: 10px solid #222;
            right: -10px;
        }

        .arrow-right {
            position: absolute;
            width: 0;
            height: 0;
            border-top: 10px solid transparent;
            border-bottom: 10px solid transparent;
            border-right: 10px solid #222;
            left: -10px;
        }

        :scope.active {
            z-index: 9999;
        }

        :scope.show {
            opacity: 0.95;
        }
    </style>
    <script>
        var TRANSITION_TIMESPAN = 200;
        this.timed = [];

        this.on('mount', function() {
            this.root.addEventListener('mouseover', this.clearTimed)
            this.root.addEventListener('mouseout', this.hide)
            this._initializeElements()
        })

        this.moveright = function(el) {
            var offset =  getOffset(el);
            if (offset[2] === 'fixed') {
                this.root.classList.add('fixed');
            }
            this._showTip('right');
            this.root.style.left = "" + (offset[0] + el.clientWidth + 6) + "px";
            this.root.style.top = "" + (offset[1]  - ((this.root.clientHeight / 2) - (el.clientHeight / 2))) + "px";
        }

        this.moveleft = function(el) {
            var offset =  getOffset(el);
            if (offset[2] === 'fixed') {
                this.root.classList.add('fixed');
            }
            this._showTip('left');
            this.root.style.left = "" + (el.offsetLeft - this.root.clientWidth - 10) + "px";
            this.root.style.top = "" + (el.offsetTop  - ((this.root.clientHeight / 2) - (el.clientHeight / 2))) + "px";
        }

        this.movebelow = function(el) {
            var offset =  getOffset(el);
            if (offset[2] === 'fixed') {
                this.root.classList.add('fixed');
            }
            this._showTip('up');
            this.up.style.left = "" + ((this.root.clientWidth / 2) -  5) + "px";
            this.root.style.left = "" + ((el.offsetLeft + (el.clientWidth / 2)) -  (this.root.clientWidth / 2)) + "px";
            this.root.style.top = "" + (el.offsetTop + el.clientHeight + 10) + "px";
        }

        this.moveabove = function(el) {
            var offset =  getOffset(el);
            if (offset[2] === 'fixed') {
                this.root.classList.add('fixed');
            }
            this._showTip('down');
            this.down.style.left = "" + ((this.root.clientWidth / 2) -  5) + "px";
            this.root.style.left = "" + ((el.offsetLeft + (el.clientWidth / 2)) -  (this.root.clientWidth / 2)) + "px";
            this.root.style.top = "" + (el.offsetTop  - this.root.clientHeight - 10) + "px";
        }

        function getOffset(el) {
            var traverse = function(el, attr, pixels) {
                if (pixels === undefined) { pixels = 0; }
                if (el == null) {
                    return pixels;
                } else {
                    pixels = pixels + el[attr];
                    return traverse(el.offsetParent, attr, pixels);
                }
            }


            var getPosition = function(el, position) {
                if (position === undefined) { position = 'static'; }
                if (el == null) {
                    return position;
                } else {
                    if (position !== 'fixed') {
                        position = window.getComputedStyle(el).position
                    }
                    return getPosition(el.offsetParent, position);
                }
            }

            var p = getPosition(el);

            if (p === 'fixed') {
                return [traverse(el, 'offsetLeft'), traverse(el, 'offsetTop'), p]
            } else {
                return [el.offsetLeft, el.offsetTop, p]
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
            var elements = this.root.parentElement.querySelectorAll('*[data-tip="' + opts.name +'"]')

            for (element in elements) {
                elements[element]._tip_target = true
                elements[element].onmouseover = this.show
                elements[element].onmouseout = this.hide
            }
        }

        this._showTip = function(name) {
            this.up.style.display = "none"
            this.left.style.display = "none"
            this.right.style.display = "none"
            this.down.style.display = "none"
            this[name].style.display = "block"
        }
    </script>
</iconic-tip>
