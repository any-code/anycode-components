<iconic-announcement>
    <yield/>
    <script>
        var DEFAULT_TIMEOUT = 3000;

        this.show = function(timeout) {
            this.root.classList.add('show')
            setTimeout(function() {
                this.hide();
            }.bind(this), timeout || DEFAULT_TIMEOUT);
        }.bind(this)

        this.hide = function() {
            this.root.classList.remove('show')
        }.bind(this)
    </script>

    <style scoped>
        :scope {
            background: #2C2C2C;
            color: #999;
            padding: 4rem;
            display: block;
            position: fixed;
            top: -16rem;
            left: 0;
            right: 0;
            height: 8rem;
            transition: all 300ms ease-in-out;
            overflow: hidden;
            z-index: 200;
            font-size: 6rem;
        }

        :scope.show {
            top: 0rem;
        }
    </style>
</iconic-announcement>
