<iconic-links class="{ shrink: shrink }">
    <div>
        <yield/>
    <div>
    <style scoped>
        :scope {
            display: block;
            position: fixed;
            margin: 0;
            padding: 0;
            height: auto;
            transition: all 200ms ease-in-out;
            left: 0;
            right: 0;
            top:0;
            height: 4.2rem;
            z-index:1;
            background: #FFF;
            white-space: nowrap;
        }

        :scope.shrink {
            padding: 0 1rem 0 4rem;
            height: auto;
            position: relative;
            clear: both;
        }

        :scope.shrink ul {
            text-align: center;
        }

        :scope div > ul {
            margin: 0;
            padding: 0;
            text-align: center;
        }

        :scope div > ul li {
            padding: 0;
            margin: 0;
            list-style: none;
            display: inline-block;
            padding-right: 0.5rem;
        }

        :scope.shrink div > ul li {
            display: block;
            padding-left:1rem;
            padding-right: 1rem;
        }

        :scope.shrink div > ul li a {
            padding-left:1rem;
        }

        :scope.shrink div > ul li a.button {
            display: block;
            margin: 1rem 0 0 1rem;
        }

        :scope div > ul li a {
            font-size: 1.5rem;
            color: rgba(0, 0, 0, 0.7);
            text-align: left;
            display: block;
            padding: 0.8rem;
            transition: all 80ms ease-in-out;
            text-decoration: none;
        }

        :scope div > ul li a.button {
            vertical-align: middle;
        }

        :scope div > ul li.separator {
            height: 0;
            border-left: 6px solid white;
        }

        :scope div > ul li ul {
            padding: 0;
            margin: 0;
        }

        :scope div > ul li ul li {
            padding: 0;
            margin: 0;
            list-style: none;
        }

        :scope div > ul li ul li a {
            font-size: 1rem;
            display: block;
            padding: 0.1rem 0.1rem 0.1rem 2rem;
            -webkit-transition: .5s all ease-out;
            -moz-transition: .5s all ease-out;
            transition: .5s all ease-out;
            text-decoration: none;
        }
    </style>
    <script>
        this.viewing = undefined;
        this.shrink = false;
        this.measured = false;

        this.on('mount', function() {
            this.measured = this.root.scrollWidth;
            this.update({
                shrink: this.root.clientWidth < this.root.scrollWidth
            })
        })

        window.addEventListener('resize', function() {
            this.update({
                shrink: false
            })
            this.update({
                measured: this.root.scrollWidth
            })
            this.update({
                shrink: this.root.clientWidth < this.root.scrollWidth
            })
        }.bind(this))
    </script>
</iconic-links>
