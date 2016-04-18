<iconic-footer class="{ shrink: shrink }">
    <article class="{ 'u-pn': pageHasNavigation }">
        <div class="row">
            <div class="twelve columns links">
                <i class="icon-anycode-badge"></i>
                <div>Create, Inspire, Be Anything.</div>
                <yield/>
                <div class="copy">
                    copyright &copy; 2015-{ year } <em>{ opts.product }</em> is a product of Anycode
                </div>
            </div>
        </div>
        <div class="row">
            <div class="columns twelve">
                <div class="tested-with u-center-text">
                    <a class="browser-stack" href="https://www.browserstack.com/" target="_blank"><span>Tested with</span> <img src="https://d3but80xmlhqzj.cloudfront.net/production/images/static/header/header-logo.svg?1451465607"></a>
                </div>
            </div>
        </div>
    <article>
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
            white-space: nowrap;
            height: 22rem;
            height: auto;
            background: #F5F5F5 no-repeat center top;
            background-size: cover;
        }

        :scope .badge, :scope .links, :scope .social {
            margin-top: 5rem;
            text-align:center;
        }

        :scope.shrink {
            padding: 0 1rem 0 4rem;
            height: auto;
            position: relative;
            clear: both;
        }

        :scope .links > ul {
            display: inline-block;
            text-align: center;
            background: rgba(255,255,255,0.5);
            text-align: center;
            width: auto;
            margin: 3.8rem auto;
            padding: 0 5rem;
        }

        :scope.shrink ul {
            text-align: center;
            display: block;
            padding: 0;
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
            font-size: 20rem;
            color: #555;
            line-height: 10rem;
        }

        .copy {
            font-size: 1.1rem;
        	font-weight: 400;
        	padding-top: 3rem;
        }

        .copy em {
            font-weight: 700;
        }

        .tested-with {
            margin: 0 auto;
            font-weight: 300;
            text-align: center;
            background: rgba(0,0,0,0.3);
            color: #FFF;
            font-size: 1.1rem;
            border-radius: 1rem;
            max-width: 16.5rem;
            margin-bottom: 3rem;
        }

        .tested-with a {
            color: #FFF;
            text-decoration: none;
        }

        .tested-with img {
            height: 2rem;
            vertical-align: middle;
            margin-top: -0.3rem;
        }
iconic-footer {

}

iconic-footer .links {
    height: auto;
}

    </style>
    <script>
        this.viewing = undefined;
        this.shrink = false;
        this.measured = false;
        this.year = (new Date()).getFullYear()
        this.gaTrackingCode = opts.gaTrackingCode || 'UA-69299537-1'
        this.gaId = opts.gaId || window.location.host + window.location.pathname + window.location.hash

        this.on('mount', function() {
            this.measured = this.root.scrollWidth;
            this.update({
                shrink: this.root.clientWidth < this.root.scrollWidth
            });

            (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
                    (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
                m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
            })(window,document,'script','//www.google-analytics.com/analytics.js','ga')
            ga('create', this.gaTrackingCode, 'auto')
            ga('send', 'pageview', this.gaId);
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
