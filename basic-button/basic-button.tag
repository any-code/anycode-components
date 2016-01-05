<basic-button class="{ inset: inset }" style="background: { color }; float: { float }; height: { size }rem; line-height: { size }rem; font-size: { fontSize }rem;" >
    <div name="container">
        <div name="text" style="height: { size }rem; "><yield/></div>
    </div>
    <script>
        this.size = parseFloat(opts.size)|| 4;
        this.fontSize = parseFloat(opts.size) * 0.8;
        this.inset = false;

        this.on('mount update', function() {
            this.color = opts.color || 'transparent';
            this.float = opts.float || 'none';
            this.inset = opts.inset !== undefined
            this.size = parseFloat(opts.size)|| 4;
            this.fontSize = parseFloat(opts.size) * 0.55;
        });
    </script>
    <style scoped>
        :scope {
            display: block;
            position: relative;
            cursor: pointer;
            margin-right: 0.5rem;
        }

        :scope.inset {
            border-radius: 0.4rem;
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
            padding-left: 2rem;
            padding-right: 2rem;
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
        }
    </style>
</basic-button>
