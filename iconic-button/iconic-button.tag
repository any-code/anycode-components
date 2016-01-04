<iconic-button class="{ inset: inset }" style="background: { color }; float: { float }; height: { size }rem; width: { size }rem; line-height: { fontSize }rem; font-size: { fontSize }rem; border-radius: { radius }rem; margin: { margin }rem;" >
    <div name="container" style=" border-radius: { radius }rem; ">
        <div name="text" style="height: { size }rem;"><yield/></div>
        <div name="hotkey" style="height: { size }rem; width: { size }rem; border-radius: { radius }rem; ">{ keyHelp }</div>
    </div>
    <script>
        var addEvent = window.document.addEventListener


        this.size = parseFloat(opts.size)|| 4;
        this.fontSize = parseFloat(opts.size) * 0.8;
        this.inset = false;

        this.on('mount', function() {
            addEvent('keypress', function(event) {
                var key = event.which, name = event.target.nodeName.toUpperCase();
                if (key === 0 || event.target.contentEditable.toUpperCase() === "TRUE" || name === "TEXTAREA" || name === "INPUT" && event.target.type.toUpperCase() === "TEXT") { return true; }




                var otherKey = key - 32;
                if (key >= 65 && key <= 90) {
                    otherKey = key + 32;
                }

                if (String.fromCharCode(key) === this.keyHelp || String.fromCharCode(otherKey) === this.keyHelp) {
                    this.activated = key;
                    return false;
                }

            }.bind(this))

            addEvent('keyup', function(event) {
                event = event || window.event;

                var key = event.which, name = event.target.nodeName.toUpperCase();
                if (key === 0 || event.target.contentEditable.toUpperCase() === "TRUE" || name === "TEXTAREA" || name === "INPUT" && event.target.type.toUpperCase() === "TEXT") { return true; }


                var visualClick = function() {
                    if (this.activated) {
                        this.activated = false;
                        this.container.classList.add('activated');
                        this.root.click();
                        setTimeout(function () {
                            this.container.classList.remove('activated');
                        }.bind(this), 600)
                    }
                }.bind(this)

                if (this.hotkey.classList.contains('help')) {
                    visualClick();
                    setTimeout(function() {
                        this.hotkey.classList.remove('help')

                    }.bind(this), 200);
                } else {
                    visualClick();
                }
            }.bind(this))

            addEvent('keydown', function(event) {

                event = event || window.event;
                var key = event.which, name = event.target.nodeName.toUpperCase();
                if (key === 0 || event.target.contentEditable.toUpperCase() === "TRUE" || name === "TEXTAREA" || name === "INPUT" && event.target.type.toUpperCase() === "TEXT") { return true; }

                if (event.shiftKey) {
                    if (this.keyHelp) {
                        this.hotkey.classList.add('help')
                    }
                } else {
                    this.hotkey.classList.remove('help')
                }

                return true;
            }.bind(this));
        })

        this.on('mount update', function() {
            this.keyHelp = opts.hotkey || undefined;
            this.color = opts.color || 'transparent';
            this.float = opts.float || 'none';
            this.buttonSize = parseFloat(opts.size)|| 4;
            this.size = this.buttonSize;
            this.radius = 0;
            this.margin = 0;
            this.fontSize = parseFloat(this.buttonSize) * 0.8;

            this.inset = opts.inset !== undefined
            if (this.inset) {
                this.radius = '' + parseFloat(this.buttonSize) * 0.1;
                this.margin = '' + parseFloat(this.buttonSize) * 0.05;
                this.size = this.buttonSize * 0.9;
                this.fontSize = parseFloat(opts.size) * 0.74;
            }
        });
    </script>
    <style scoped>
        :scope {
            display: block;
            position: relative;
            cursor: pointer;
        }

        :scope.inset {
            border-radius: 0.4rem;
        }

        :scope.size-10 {
            height: 10rem;
            width: 10rem;
            font-size: 8rem;
            line-height: 8rem;
            border-radius: 1rem;
        }

        @-webkit-keyframes iconicButtonFlash {
            from {
                background: rgba(255,255,255, 0.5);
            }

            to {
                background: rgba(255,255,255, 0.3);
            }
        }

        @keyframes iconicButtonFlash {
            from {
                background: rgba(255,255,255, 0.5);
            }

            to {
                background: rgba(255,255,255, 0.3);
            }
        }

        div[name="container"] {
            background: rgba(255,255,255, 0);
            transition: all 400ms ease-in-out;
            transition-delay: 0ms;

        }

        :scope.inset div[name="container"] {
            border-radius: 0.4rem;
        }

        div[name="container"]:hover {
            background: rgba(255,255,255, 0.3);
        }

        div[name="container"]:active {
            -webkit-animation: iconicButtonFlash 200ms 1;
            -o-animation: iconicButtonFlash 200ms 1;
            animation: iconicButtonFlash 200ms 1;
        }

        div[name="container"].activated {
            -webkit-animation: iconicButtonFlash 200ms 1;
            -o-animation: iconicButtonFlash 200ms 1;
            animation: iconicButtonFlash 200ms 1;
        }

        div[name="text"] {
            color: rgba(255,255,255,0.7);
            font-weight: bolder;
            text-align: center;
            vertical-align: center;
            transition: all 600ms ease-in-out;
            transition-delay: 0ms;
            -webkit-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
            user-select: none;
            margin-top: 0%;
            font-size: 100%;
        }

        div[name="hotkey"] {
            display: table-cell;
            opacity: 0;
            background: rgba(255,255,255,0.8);
            position: absolute;
            z-index: 5;
            top: 0;
            left: 0;
            color: rgba(0,0,0,0.4);
            font-weight: bolder;
            text-align: center;
            vertical-align: center;
            transition: all 200ms ease-in-out;
            transition-delay: 0ms;
            -webkit-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
            user-select: none;
            margin-top: 0%;
            font-size: 100%;
        }

        div[name="hotkey"].help {
            opacity: 1;
        }

        div[name="text"] i {
            margin-top: 22%;
            font-size: 75%;
        }

        :scope.inset div[name="text"] i {
            margin-top: 20%;
            font-size: 69%;
        }
    </style>
</iconic-button>
