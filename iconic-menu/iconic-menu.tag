<iconic-menu>
    <div name="left" class="arrow-left"></div>
    <div name="right"  class="arrow-right"></div>
    <div name="content">
        <yield/>
    </div>
    <style scoped>
        :scope {
            position: absolute;
            display: block;
            box-shadow: 0 0 0.8rem rgba(0, 0, 0, 0.6);
            background: #222;
            padding: 0.3rem 0.2rem 0.2rem 0.3rem;
            font-size: 1.5rem;
            border-radius: 0.3rem;
            color: #FFF;
            opacity: 0;
            margin: 0 auto;
            z-index: -1;
            transition: opacity 200ms ease-in-out;
            -webkit-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
            user-select: none;
            pointer-events: none;
        }

        :scope.navigation-tip {
            padding: 0.2rem 1rem 0.2rem 0.2rem;
            border-radius: 0.4rem;
        }

        :scope.navigation-tip iconic-button {
            vertical-align: middle;
            margin: 0;
        }

        :scope.navigation-tip .arrow-right {
            top: 0.78rem;
        }

        :scope.fixed {
            position: fixed!important;
        }

        :scope.active {
            pointer-events: auto;
        }

        .content {
            padding: 0;
            margin: 0;
        }

        .arrow-left {
            position: absolute;
            width: 0;
            height: 0;
            border-top: 10px solid transparent;
            border-bottom: 10px solid transparent;
            border-left: 10px solid #222;
            right: -10px;
            transition: opacity 200ms ease-in-out;
        }

        .arrow-right {
            position: absolute;
            width: 0;
            height: 0;
            border-top: 10px solid transparent;
            border-bottom: 10px solid transparent;
            border-right: 10px solid #222;
            left: -10px;
            transition: opacity 200ms ease-in-out;
        }

        :scope.active {
            z-index: 9999;
        }

        :scope.show {
            opacity: 0.95;
        }


        :scope ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }


        :scope ul li {
            padding: 0;
            margin: 0;
            display: block;
            position: relative;
        }

        :scope a {
            padding: 0;
            margin: 0;
            color: #FFF;
            cursor: pointer;
            display: block;
            position: relative;
            padding-top: 0rem;
            padding:bottom: 0rem;
            padding-right: 2rem;
            height: 3rem;
            margin: 0.2rem 0.2rem 0.3rem 0.1rem;
            border: 0.1rem solid rgba(0,0,0,0);
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
            this._showTip('right', el);
            this.root.style.left = "" + (measure(el, 'Left') + el.clientWidth + 10) + "px";
            if (el.clientHeight > 20) {
                this.root.style.top = "" + measure(el, 'Top') + "px";
            } else {
                this.root.style.top = "" + (measure(el, 'Top') - ((20 - el.clientHeight) / 2)) + "px";
            }
        }.bind(this)

        this.moveleft = function(el) {
            this._showTip('left', el);
            this.root.style.left = "" + (measure(el, 'Left') - this.root.clientWidth - 10) + "px";
            if (el.clientHeight > 20) {
                this.root.style.top = "" + measure(el, 'Top') + "px";
            } else {
                this.root.style.top = "" + (measure(el, 'Top') - 10) + "px";
            }
        }.bind(this)

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
                    var target = this._findTarget(event.target),
                        left = measure(target, 'Left'),
                        position = 'right';

                    if (left > window.innerWidth * 0.75 && window.innerWidth > this.root.clientWidth) {
                        position ='left';
                    }
                    this['move' + position].call(this, target)
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
            var elements = this.root.parentElement.querySelectorAll('*[data-menu="' + opts.name +'"]'),
                element;

            for(element = 0; element < elements.length; element++) {
                elements[element]._tip_target = true
                elements[element].addEventListener('mouseover', this.show)
                elements[element].addEventListener('mouseout', this.hide)
             }
        }

        this._showTip = function(name, el) {
            this.left.style.display = "none"
            this.right.style.display = "none"
            if (el.clientHeight > 20) {
                this.left.style.top = "" + ((el.clientHeight / 2) - 8) + "px";
                this.right.style.top = "" + ((el.clientHeight / 2) - 8) + "px";
            } else {
                this.left.style.top = "" + (((20 - el.clientHeight) / 2) + 10) + "px";
                this.right.style.top = "" + (((20 - el.clientHeight) / 2) + 10) + "px";
            }
            this[name].style.display = "block"
        }
    </script>
</iconic-menu>
