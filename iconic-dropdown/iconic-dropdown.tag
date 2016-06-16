<iconic-dropdown>

    <div name="dd" class="dd">
        <div name="ddTrigger" onclick="{ onTriggerClick }" class="dd-trigger opener u-nd button button-extra-small"><yield from="trigger"/></div>
        <div name="ddContent" class="dd-content">
            <yield from="links"/>
        </div>
    </div>

    <script>

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
            var t = event.target
            while (t && !t.classList.contains('dd-trigger')) t = t.parentElement

            // if the target element exists and it is this target element break out
            if (t && t == this.ddTrigger) return

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
        .dd-trigger { cursor: pointer; padding:0; min-width: 3rem; font-size: 1.2rem; line-height: 3.2rem; }
        .dd-trigger i { padding-left: 0.8rem; }
        .dd-trigger span { padding-left: 0.8rem; }
        .dd-trigger i:only-child { padding: 0; }
        .dd-trigger i + span { padding-left: 0.5rem; padding-right: 0.8rem }
        .dd-trigger span + i { padding-right: 0.8rem }
        .dd-content a { display: block; padding: 0.7rem 1rem; font-size: 1.2rem; text-transform: uppercase; }
        .dd-content { display: none; }
        .open .dd-content { display:block; }
    </style>

</iconic-dropdown>
