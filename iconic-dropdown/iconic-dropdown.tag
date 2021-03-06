<iconic-dropdown>

    <div name="dd" class="dd">
        <div name="ddTrigger" onclick="{ onTriggerClick }" class="dd-trigger opener u-nd"><yield from="trigger"/></div>
        <div name="ddContent" class="dd-content">
            <yield from="links"/>
        </div>
    </div>

    <script>
        this.contentClickable = !!opts.contentClickable;

        this.onTriggerClick = function(event) {

            // set the width of the dropdown to be
            // at least the width of the trigger
            this.ddContent.style.minWidth = (this.ddTrigger.clientWidth) + 'px'

            // toggle the dropdown
            this.dd.classList.toggle("open")

            // add class if dropdown width is actually
            // greater than the trigger width
            this.ddTrigger.clientWidth < this.ddContent.clientWidth ?
                this.dd.classList.add('oversize') : this.dd.classList.remove('oversize')

        }.bind(this)

        this.onWindowClick = function(event) {

            // find the trigger element of the event target if it has one
            var t = event.target,
                c = event.target;

            while (t && !t.classList.contains('dd-trigger')) t = t.parentElement
            while (c && !c.classList.contains('interactive')) c = c.parentElement

            // if the target element exists and it is this target element break out
            if ((t && t == this.ddTrigger) || c) return

            // close the dropdown
            this.dd.classList.remove("open")
        }

        this.on('mount', function() {

            // when the tag is mounted add the window click event listener
            window.addEventListener('click', this.onWindowClick.bind(this), false)
        })

        this.on('unmount', function() {

            // when the tag is unmounted kill the window click event listener
            window.removeEventListener('click', this.onWindowClick.bind(this), false)
        })

    </script>

    <style scoped>
        :scope { display: inline-block; }
        .dd { position: relative; display: inline-block; }
        .dd-trigger { border-radius: 4px; border-style: solid; border-width: 1px; box-sizing: border-box; cursor: pointer;
            font-size: 1.2rem; height: auto; letter-spacing: 0; line-height: 2.8rem; min-width: 3rem; padding:0;
            text-align: center; vertical-align: top; }
        .dd-trigger i { padding-left: 0.8rem; }
        .dd-trigger span { padding-left: 0.8rem; -webkit-touch-callout: none;
            -webkit-user-select: none; -khtml-user-select: none; -moz-user-select: none; -ms-user-select: none;
            user-select: none; }
        .dd-trigger i:only-child { padding: 0; line-height: 2.4rem; top: 0.2rem; left: -0.05rem; position: relative; }
        .dd-trigger i + span { padding-left: 0.5rem; padding-right: 0.8rem }
        .dd-trigger span + i { padding-right: 0.8rem }
        .dd-content input[type="checkbox"], .dd-content input[type="radio"] { display: inline-block; margin-top:0.5rem;
            margin-bottom: 0; padding-bottom: 0; }
        .dd-content .interactive { padding-top:0.5rem; padding-bottom:0.5rem; }
        .dd-content label { display: inline-block; position: absolute; padding: 0.6rem 1rem 0.5rem 2.7rem; font-size: 1.2rem;
            text-transform: uppercase; font-weight: 300; margin-top: -0.4rem; width: auto; left: 0; right: 0;
            white-space: normal; height: auto; clear: both; }
        .dd-content a { padding-left:2.7rem; }
        .dd-content a, .dd-content item { display: block; padding: 0.7rem 1rem; font-size: 1.2rem; text-transform: uppercase; }
        .dd-content .interactive label, .dd-content .interactive span { -webkit-touch-callout: none;
            -webkit-user-select: none; -khtml-user-select: none; -moz-user-select: none; -ms-user-select: none;
            user-select: none;
        }
        .dd-content { display: none; }
        .open .dd-content { display:block; }
    </style>

</iconic-dropdown>
