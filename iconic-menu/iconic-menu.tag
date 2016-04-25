<iconic-menu>
    <div name="left" class="arrow-left"></div>
    <div name="right"  class="arrow-right"></div>
    <div name="content">
        <yield/>
    </div>
    <script>
        var TRANSITION_TIMESPAN = 200;
        this.timed = [];
        this.queue = [];

        this.on('mount', function() {
            this._initializeTriggers()
            this.root.addEventListener('mouseover', this.cancelHideHandler, true)
        })

        this._showTip = function(target) {
            var el = this._findTarget(target),
                name = this._getPosition(target),
                top = this._measure(el, 'Top'),
                pushUp = this.root.clientHeight + top > window.innerHeight;
            this.root.style.zIndex = 9999;
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

            if (name=='right') this.root.style.left = "" + (this._measure(el, 'Left') + el.clientWidth + 10) + "px";
            if (name=='left') this.root.style.left = "" + (this._measure(el, 'Left') - this.root.clientWidth - 10) + "px";

            if (el.clientHeight > 20) {
                this.root.style.top = "" + (this.root.clientHeight + top > window.innerHeight ? this._measure(el, 'Top') - (this.root.clientHeight - el.clientHeight - 2) : this._measure(el, 'Top')) + "px";
            } else {
                if (pushUp){
                    this.root.style.top = "" + ((this._measure(el, 'Top') - this.root.clientHeight) + el.clientHeight + 12) + "px";
                } else {
                    this.root.style.top = "" + (this._measure(el, 'Top') - 10) + "px";
                }
            }

            this.root.style.zIndex = 9999;
            this.root.classList.add('fixed')
            this.root.classList.add('active')
            this.root.classList.add('show')
        }

        this._measure = function(el, attr, pixels) {
            if (pixels === undefined) { pixels = 0; }
            if (el == null) {
                return pixels;
            } else {
                pixels = pixels + (el['offset' + attr] - el['scroll' + attr]);
                return this._measure(el.offsetParent, attr, pixels);
            }
        }

        this._findTarget = function(target) {
            do {
                if (target.__tip_target)
                    return target

                target = target.parentElement

            } while (target !== null)

            return target
        }

        this._getPosition = function(target) {
            var target = this._findTarget(target),
                left = this._measure(target, 'Left'),
                position = 'right';

            if (left > window.innerWidth * 0.75 && window.innerWidth > this.root.clientWidth) {
                position ='left';
            }

            return position;
        }.bind(this)

        this.cancelHideHandler = function() {
            this.timed.map(clearTimeout)
            this.timed = []
        }.bind(this)

        this._hide = function(immediate) {
            this.timed.push(setTimeout(function(){
                this.documentClickUnbinder();
                this.cancelHideHandler();
                this.root.classList.remove('show')
                this._sendToBack()
                this.trigger('hide');
            }.bind(this), immediate ? 1 : TRANSITION_TIMESPAN))
        }

        this.documentClickHandler = function(event) {
            this.cancelHideHandler();
            this.documentClickUnbinder();
            this._hide(true);
        }.bind(this)

        this.documentClickBinder = function() {
            document.addEventListener('click', this.documentClickHandler, true)
        }.bind(this)

        this.documentClickUnbinder = function() {
            document.removeEventListener('click', this.documentClickHandler, true)
        }.bind(this)

        this.hide = function() {
            this._hide(false)
        }.bind(this)

        this.on('show', function() {

        })

        this.show = function(event) {
            this.cancelHideHandler();

            var hideAction = event.target.__off || 'mouseout',
                showAction = event.target.__on || 'mouseover';

            // Sanitize Events
            this.root.removeEventListener('mouseout', this.hide, true)
            this.documentClickUnbinder()

            if (hideAction == 'mouseout')
                this.root.addEventListener('mouseout', this.hide, true)

            if (showAction == 'mouseover')
                // When a menu item is clicked the menu should be dismissed
                this.root.addEventListener('click', this.documentClickHandler, true)
            else
                this.documentClickBinder()

            // When a element item is clicked the menu should be dismissed
            if (showAction == 'mouseover')
                this.root.addEventListener('click', this.documentClickHandler, true)

            if (showAction == 'focus') {
                event.target.addEventListener('click', this.cancelHideHandler, true)
                this.documentClickBinder()
            }

            this.childFocusableClick = function() {
                this.cancelHideHandler();
                this.documentClickBinder();
            }.bind(this)

            if (hideAction == 'blur') {
                var nodeList = this.root.querySelectorAll('input, select, textarea'),
                    inputs = Array.prototype.slice.call(nodeList, 0);

                this.root.removeEventListener('click', this.childFocusableClick, true);
                this.root.addEventListener('click', this.childFocusableClick, true);
                inputs.forEach(function(_input_) {
                    _input_.tabIndex = event.target.tabIndex;

                    // Sanitize input event handlers
                    _input_.removeEventListener('focus', this.cancelHideHandler, true);
                    _input_.removeEventListener('click', this.childFocusableClick, true);
                    _input_.addEventListener('click', this.childFocusableClick, true);
                    if (_input_.getAttribute('type') !== 'checkbox') {
                        _input_.addEventListener('focus', this.cancelHideHandler, true);
                    }
                }.bind(this))

                if (inputs.length > 0) {
                    inputs[inputs.length-1].addEventListener('keydown', function(_event_) {
                        _event_ = _event_ || window.event;
                        var key = _event_.which;
                        if (key == 9 && !_event_.shiftKey) {
                            event.target.focus()
                        }
                    })

                    inputs[0].addEventListener('keydown', function(_event_) {
                        _event_ = _event_ || window.event;
                        var key = _event_.which;
                        if (key == 9 && _event_.shiftKey) {
                            event.target.focus()
                            _event_.stopPropagation()
                            _event_.preventDefault()
                            return false;
                        }
                    })

                    event.target.addEventListener('keydown', function(_event_) {
                        _event_ = _event_ || window.event;
                        var key = _event_.which;
                        if (key == 9 && !_event_.shiftKey) {
                            inputs[0].focus()
                            _event_.stopPropagation()
                            _event_.preventDefault()
                            return false;
                        }
                    }.bind(this))
                }
            }

            this._showTip.call(this, event.target);
            this.trigger('show');
        }.bind(this)

        this.mouseover = function(event) {
            this.cancelHideHandler()
        }.bind(this)

        this._sendToBack = function() {
            this.cancelHideHandler()

            this.timed.push(setTimeout(function() {
                this.root.style.zIndex = -1;
                this.root.classList.remove('active')
                this.root.style.top = "-10000px";
            }.bind(this), TRANSITION_TIMESPAN))
        }

        this._initializeTriggers = function() {
            var nodeList = this.root.parentElement.querySelectorAll('*[data-menu="' + opts.name +'"]');
            this.triggers = Array.prototype.slice.call(nodeList, 0);
            this.triggers.forEach(function(el) {
                el.__on = el.getAttribute('data-menu-show') ? el.getAttribute('data-menu-show') : 'mouseover',
                el.__off = el.getAttribute('data-menu-hide') ? el.getAttribute('data-menu-hide') : 'mouseout';
                el.__tip_target = true;
                el.addEventListener('mouseover', this.cancelHideHandler, true)
                el.addEventListener(el.__on, this.show, true)
                if (el.__off !== 'click')
                    el.addEventListener(el.__off, this.hide, true)
            }.bind(this))
        }


    </script>
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
            transition: z-index 1ms step-end 0ms, opacity 200ms ease-in-out 0ms;
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
            z-index: 9999;
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

        :scope.show {
            opacity: 0.95;
            z-index: 9999;
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

        :scope div.form {
            margin: 0;
            padding: 1rem;
        }

        :scope div.form * {
            margin: 0;
            padding: 0;
        }

        :scope a {
            padding: 0;
            margin: 0;
            color: #FFF;
            cursor: pointer;
            display: block;
            position: relative;
            padding-top: 0rem;
            padding-bottom: 0rem;
            padding-right: 2rem;
            height: 3rem;
            margin: 0.2rem 0.2rem 0.3rem 0.1rem;
            border: 0.1rem solid rgba(0,0,0,0);
        }

    </style>
</iconic-menu>
