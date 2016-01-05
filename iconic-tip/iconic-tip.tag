<iconic-tip>
    <div name="left" class="arrow-left"></div>
    <div name="right"  class="arrow-right"></div>
    <div name="up" class="arrow-up"></div>
    <div name="down" class="arrow-down"></div>
    <yield/>
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
            z-index: 500;
        }

        :scope.animate {
            transition: opacity 200ms ease-in-out;
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

        :scope.show {
            opacity: 0.95;
        }
    </style>
    <script>

        this.showTip = function(name) {
            this.up.style.display = "none"
            this.left.style.display = "none"
            this.right.style.display = "none"
            this.down.style.display = "none"
            this[name].style.display = "block"
        }

        this.moveright = function(el) {
            setTimeout(function(){
                this.showTip('right');
                this.root.style.left = "" + (el.offsetLeft + el.clientWidth + 10) + "px";
                this.root.style.top = "" + (el.offsetTop  - ((this.root.clientHeight / 2) - (el.clientHeight / 2))) + "px";
            }.bind(this), 1);
        }

        this.moveleft = function(el) {
            setTimeout(function(){
                this.showTip('left');
                this.root.style.left = "" + (el.offsetLeft - this.root.clientWidth - 10) + "px";
                this.root.style.top = "" + (el.offsetTop  - ((this.root.clientHeight / 2) - (el.clientHeight / 2))) + "px";
                this.root.classList.add('animate')
            }.bind(this), 1);
        }

        this.movebelow = function(el) {
            setTimeout(function(){
                this.showTip('up');
                this.root.style.left = "" + ((el.offsetLeft + (el.clientWidth / 2)) -  (this.root.clientWidth / 2)) + "px";
                this.up.style.left = "" + ((this.root.clientWidth / 2) -  5) + "px";
                this.root.style.top = "" + (el.offsetTop + el.clientHeight + 10) + "px";
                this.root.classList.add('animate')
            }.bind(this), 1);
        }

        this.moveabove = function(el) {
            setTimeout(function(){
                this.showTip('down');
                this.root.style.left = "" + ((el.offsetLeft + (el.clientWidth / 2)) -  (this.root.clientWidth / 2)) + "px";
                this.down.style.left = "" + ((this.root.clientWidth / 2) -  5) + "px";
                this.root.style.top = "" + (el.offsetTop  - this.root.clientHeight - 10) + "px";
                this.root.classList.add('animate')
            }.bind(this), 1);
        }

        this.on('mount', function() {
            var tip = this.root,
                tfo, efo;

            var element = document.querySelector('button[data-tip="' + opts.name +'"]');
            this['move' + (opts.position || 'left')].call(this, element);


            this.root.onmouseover = function() {
                clearTimeout(efo);
                clearTimeout(tfo);
            }

            this.root.onmouseout = function() {
                tfo = setTimeout(function(){
                    this.root.classList.remove('show')
                    this.update();
                }.bind(this),300);
            }.bind(this)

            element.onmouseover = function() {
                clearTimeout(tfo);
                clearTimeout(efo);
                this['move' + (opts.position || 'left')].call(this, element);
                this.root.classList.add('show')
                this.update();
            }.bind(this)

            element.onmouseout = function() {
                efo = setTimeout(function(){
                    this.root.classList.remove('show')
                    this.update();
                }.bind(this),300);
            }.bind(this)

            this.root.classList.add('animate')
        })
    </script>
</iconic-tip>
