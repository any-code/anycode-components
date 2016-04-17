<iconic-footer class="{ shrink: shrink }">
    <article class="u-pn">
            <div class="row">
                <div class="three columns badge">
                    <yield from="badge"/>
                </div>
                <div class="six columns links">
                    <yield from="links"/>
                </div>
                <div class="three columns social">
                    <yield from="social"/>
                </div>
            </div>
    <article>
    <iconic-tip position="below" delay="1" name="links-tip" class="links-tip"></iconic-tip>
    <style scoped>
        :scope {
            display: block;
            position: relative;
            margin: 0;
            padding: 0;
            height: auto;
            transition: all 200ms ease-in-out;
            left: 0;
            right: 0;
            height: 4.2rem;
            white-space: nowrap;
            height: 22rem;
        }

        :scope .badge, :scope .links, :scope .social {
            height: 10rem;
            margin-top: 5rem;
            text-align:center;
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

        :scope .links > ul {
            margin: 3.8rem 0 0 0;
            padding: 0;
            text-align: center;
        }

        :scope .links > ul li {
            padding: 0;
            margin: 0;
            list-style: none;
            display: inline-block;
            padding-right: 0.5rem;
        }

        :scope.shrink .links > ul li {
            display: block;
            padding-left:1rem;
            padding-right: 1rem;
        }

        :scope.shrink .links > ul li a {
            padding-left:1rem;
        }

        :scope.shrink .links > ul li a.button {
            display: block;
            margin: 1rem 0 0 1rem;
        }

        :scope .links > ul li a {
            font-size: 1.1rem;
            font-weight: 300;
            text-transform: uppercase;
            color: rgba(0, 0, 0, 0.7);
            text-align: left;
            display: block;
            padding: 0.8rem;
            transition: all 80ms ease-in-out;
            text-decoration: none;
        }

        :scope .links > ul li a.button {
            vertical-align: middle;
        }

        :scope .links > ul li.separator {
            height: 0;
            border-left: 6px solid white;
        }

        :scope .links > ul li ul {
            padding: 0;
            margin: 0;
        }

        :scope .links > ul li ul li {
            padding: 0;
            margin: 0;
            list-style: none;
        }

        :scope .links > ul li ul li a {
            font-size: 1rem;
            display: block;
            padding: 0.1rem 0.1rem 0.1rem 2rem;
            -webkit-transition: .5s all ease-out;
            -moz-transition: .5s all ease-out;
            transition: .5s all ease-out;
            text-decoration: none;
        }

        .icon-anycode-badge {
            font-size: 8rem;
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
</iconic-footer>
