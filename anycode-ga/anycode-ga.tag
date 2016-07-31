<anycode-ga>
    <!-- WE RISE BY LIFTING OTHERS -->
    <script>
        // default tracking code is for anycode.io
        this.gaTrackingCode = opts.gaTrackingCode || 'UA-69299537-1'
        this.gaId = opts.gaId || window.location.host + window.location.pathname + window.location.hash

        this.on('mount', function() {
            if (typeof(ga) === "undefined") {
                (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
                      (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
                  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
                })(window,document,'script','//www.google-analytics.com/analytics.js','ga')
            }

            ga('create', this.gaTrackingCode, 'auto')
            ga('send', 'pageview', this.gaId);
        })
    </script>
</anycode-ga>
