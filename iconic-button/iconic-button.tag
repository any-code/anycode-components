<iconic-button>
    <div name="container" class="inner">
        <div name="text"><yield/></div>
        <div name="hotkey">{ keyHelp[0] }</div>
    </div>
    <script>
        this.on('mount', function() {
            this.root.classList.add('button');
            this.root.classList.add('icon-extra-small');
            this.keyHelp = [];

            document.body.addEventListener('keypress', function(event) {
                event = event || window.event;
                var key = event.which, name = event.target.nodeName.toUpperCase();

                if (key === 0 || event.target.contentEditable.toUpperCase() === "TRUE" || name === "TEXTAREA" ||
                    name === "INPUT") { return true; }
                if (this.keyHelp && this.keyHelp.indexOf(String.fromCharCode(key)) > -1) {
                    this.activated = key;
                    return false;
                }
            }.bind(this))

            document.body.addEventListener('keyup', function(event) {
                event = event || window.event;
                var key = event.which, name = event.target.nodeName.toUpperCase();
                if (key === 0 || event.target.contentEditable.toUpperCase() === "TRUE" || name === "TEXTAREA" ||
                    name === "INPUT") { return true; }

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

            document.body.addEventListener('keydown', function(event) {
                event = event || window.event;
                var key = event.which, name = event.target.nodeName.toUpperCase();
                if (key === 0 || event.target.contentEditable.toUpperCase() === "TRUE" || name === "TEXTAREA" ||
                    name === "INPUT") { return true; }
                if (event.shiftKey && event.ctrlKey && this.keyHelp) {
                    this.hotkey.classList.add('help')
                } else {
                    this.hotkey.classList.remove('help')
                }
                return true;
            }.bind(this));
        })

        this.on('mount update', function() {
            this.keyHelp = opts.hotkey || undefined;
        });
    </script>
    <style scoped>
        :scope {
            display: inline-block;
            position: relative;
            cursor: pointer;
        }

        .inner {
            line-height: 2.6rem;
        }

        .inner i {
            vertical-align: middle;
        }

        div[name="hotkey"] {
            position: absolute;
            display: block;
            opacity: 0;
            background: rgba(255,255,255,1);
            border: 1px solid rgba(0,0,0,0.2);
            line-height: 2.6rem;
            position: absolute;
            z-index: 5;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            color: rgba(0,0,0,0.8);
            font-weight: 600;
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
    </style>
</iconic-button>
