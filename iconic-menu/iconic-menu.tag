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
            this._initializeElements()
        })

        this._showTip = function(name, el) {
            var top = measure(el, 'Top'),
                pushUp = this.root.clientHeight + top > window.innerHeight;
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

            if (name=='right') this.root.style.left = "" + (measure(el, 'Left') + el.clientWidth + 10) + "px";
            if (name=='left') this.root.style.left = "" + (measure(el, 'Left') - this.root.clientWidth - 10) + "px";

            if (el.clientHeight > 20) {
                this.root.style.top = "" + (this.root.clientHeight + top > window.innerHeight ? measure(el, 'Top') - (this.root.clientHeight - el.clientHeight - 2) : measure(el, 'Top')) + "px";
            } else {
                if (pushUp){
                    this.root.style.top = "" + ((measure(el, 'Top') - this.root.clientHeight) + el.clientHeight + 12) + "px";
                } else {
                    this.root.style.top = "" + (measure(el, 'Top') - 10) + "px";
                }
            }
        }

        this.moveright = function(el) {
            this._showTip('right', el);

        }.bind(this)

        this.moveleft = function(el) {
            this._showTip('left', el);
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

        this._hideMenu = function(documentClick) {
            this.clearTimed()
            this.timed.push(setTimeout(function(){
                this.root.classList.remove('show')
                this._sendToBack()
                if (documentClick)
                    document.removeEventListener('click', this.clickHide)
            }.bind(this), documentClick ? 0 : TRANSITION_TIMESPAN))
        }

        this.hide = function() {
            this._hideMenu(false)
        }.bind(this)

        this.clickHide = function() {
            this._hideMenu(true)
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
                        position = 'right',
                        hideAction = target.getAttribute('data-menu-hide') || 'mouseout',
                        showAction = target.getAttribute('data-menu-show') || 'mouseover';

                    this.root.removeEventListener('mouseout', this.hide)
                    this.root.removeEventListener('click', this.refocus.bind(target))
                    document.removeEventListener('click', this.clickHide)

                    if (left > window.innerWidth * 0.75 && window.innerWidth > this.root.clientWidth) {
                        position ='left';
                    }

                    this['move' + position].call(this, target)
                    this.root.classList.add('active')
                    this.root.classList.add('show')

                    if (hideAction == 'mouseout' )
                        this.root.addEventListener('mouseout', this.hide)

                    if (hideAction != 'blur' && showAction != 'mouseover')
                        document.addEventListener('click', this.clickHide)

                    if (showAction == 'mouseover')
                        this.root.addEventListener('click', this.clickHide)

                    if (showAction == 'focus' )
                        this.root.addEventListener('click', this.refocus.bind(target))

                }.bind(this), parseInt(opts.delay,10) || 1000))
            }
        }.bind(this)

        this.refocus = function(event) {
            this.focus();
        }

        this.mouseover = function(event) {
            this.clearTimed()
        }.bind(this)

        this._sendToBack = function() {
            this.clearTimed()

            this.timed.push(setTimeout(function() {
                this.root.classList.remove('active')
                this.root.style.top = "-10000px";
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
                var on = elements[element].getAttribute('data-menu-show') ? elements[element].getAttribute('data-menu-show') : 'mouseover',
                    off = elements[element].getAttribute('data-menu-hide') ? elements[element].getAttribute('data-menu-hide') : 'mouseout';
                elements[element]._tip_target = true
                if (on != 'mouseover') {
                    elements[element].addEventListener('mouseover', this.mouseover)
                }
                elements[element].addEventListener(on, this.show)

                if (off != 'click') {
                    elements[element].addEventListener(off, this.hide)
                }
             }

             this.root.addEventListener('mouseover', this.clearTimed)
        }


    </script>
</iconic-menu>
