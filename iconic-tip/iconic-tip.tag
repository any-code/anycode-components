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
            box-shadow: 0 0 0.8rem rgba(0, 0, 0, 0.6);
            background: #222;
            padding: 1rem;
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


        .arrow-up {
            position: absolute;
            width: auto;
            height: 0;
            border-left: 10px solid transparent;
            border-right: 10px solid transparent;
            border-bottom: 10px solid #222;
            margin: 0 auto;
            top: -10px;
            transition: opacity 200ms ease-in-out;
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
            transition: opacity 200ms ease-in-out;
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
            this._showTip('right');
            this.left.style.top = "" + ((this.root.cleintHeight / 2) -  10) + "px";
            this.root.style.left = "" + (measure(el, 'Left') + el.clientWidth + 10) + "px";
            this.root.style.top = "" + (measure(el, 'Top')  - ((this.root.clientHeight / 2) - (el.clientHeight / 2))) + "px";
        }

        this.moveleft = function(el) {
            this._showTip('left');
            this.right.style.top = "" + ((this.root.clientHeight / 2) -  10) + "px";
            this.root.style.left = "" + (measure(el, 'Left') - this.root.clientWidth - 10) + "px";
            this.root.style.top = "" + (measure(el, 'Top')  - ((this.root.clientHeight / 2) - (el.clientHeight / 2))) + "px";
        }

        this.movebelow = function(el) {
            this._showTip('up');
            this.up.style.left = "" + ((this.root.clientWidth / 2) -  10) + "px";
            this.root.style.left = "" + ((measure(el, 'Left')  + (el.clientWidth / 2)) -  (this.root.clientWidth / 2)) + "px";
            this.root.style.top = "" + (measure(el, 'Top') + el.clientHeight + 10) + "px";
        }

        this.moveabove = function(el) {
            this._showTip('down');
            this.down.style.left = "" + ((this.root.clientWidth / 2) - 10) + "px";
            this.root.style.left = "" + ((measure(el, 'Left')  + (el.clientWidth / 2)) -  (this.root.clientWidth / 2)) + "px";
            this.root.style.top = "" + (measure(el, 'Top')  - this.root.clientHeight - 10) + "px";
        }

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
            document.body.appendChild(this.root); 

            var elements = this.root.parentElement.querySelectorAll('*[data-tip="' + opts.name +'"]'),
                element;

            for(element = 0; element < elements.length; element++) {
                elements[element]._tip_target = true
                elements[element].addEventListener('mouseover', this.show)
                elements[element].addEventListener('mouseout', this.hide)
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
