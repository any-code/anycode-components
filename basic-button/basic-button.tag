<basic-button style="background: { color }" >
    <div name="container">
        <div name="text"><yield/></div>
    </div>
    <script>
        this.size = parseFloat(opts.size)|| 4;
        this.fontSize = 2;

        this.on('mount update', function() {
            this.color = opts.color || 'blue';
            this.size = parseFloat(opts.size)|| 4;
        });
    </script>
    <style scoped>
        :scope {
            height: 5rem;
            line-height:4.8rem;
            display: inline-block;
            position: relative;
            cursor: pointer;
            border-radius: 0.4rem;
            font-size: 2rem;
            vertical-align: top;
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
            padding: 0 3rem;
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
            color: rgba(255,255,255,1);
            text-align: center;
            vertical-align: center;
            -webkit-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
            user-select: none;
        }
    </style>
</basic-button>
