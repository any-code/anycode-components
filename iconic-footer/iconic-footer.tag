<iconic-footer class="{ shrink: shrink }">

    <article class="{ 'u-pn': pageHasNavigation }">
        <div class="container">
            <div class="row">
                <div class="twelve columns links">
                    <i class="f-brand icon-anycode-badge"></i>
                    <p class="f-tagline u-center-text">Create, Inspire, Be Anything.</p>
                    <yield/>
                    <div class="copy u-center-text">
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
        </div>
        <anycode-ga></anycode-ga>
    <article>

    <script>
        // set the current year
        this.year = (new Date()).getFullYear()
    </script>

    <style scoped>
        :scope { display: block; margin: 0; height: auto; padding: 0; position: relative;
            transition: all 200ms ease-in-out; }
        :scope .container { padding: 0 1rem; }
        .f-brand { display: inline-block; line-height: 10rem; position: relative; text-align: center; width: 100%; }
        .links ul { text-align: center; display: block; padding: 0; }
        .links ul li { text-align: center; display: block; padding: 0; margin: 0 0 0.2rem 0; }
        .links ul li a { font-size: 1.1rem; font-weight: 300; text-transform: uppercase; text-align: center;
            display: block; padding: 0.4rem; transition: all 80ms ease-in-out; text-decoration: none; }
        .copy { font-size: 0.9rem; font-weight: 400; padding-top: 1.5rem; }
        .copy em { font-weight: 700; }
        .tested-with { margin: 0.2rem auto; font-weight: 300; text-align: center; border-radius: 1rem; margin-bottom: 3rem; }
        .tested-with a { color: #FFF; text-decoration: none; }
        .tested-with img { height: 1.5rem; vertical-align: middle; margin-top: -0.3rem; }
        @media (min-width: 400px) {
            .links > ul li { display: inline-block; }
            .links > ul li a { font-size: 1.1rem; padding: 0.8rem; }
            .copy { font-size: 1.1rem; padding-top: 3rem; }
        }
    </style>

</iconic-footer>
