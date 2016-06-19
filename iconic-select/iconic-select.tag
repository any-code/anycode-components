<iconic-select>

    <div name="dd" class="dd">
        <div name="ddTrigger" onclick="{ onTriggerClick }" class="dd-trigger opener u-nd">
            <selected-item name="selectedNode">{ selected }</selected-item>
            <placeholder if="{ placeholder }" >{ placeholder }</placeholder>
            <i class="icon-menu opener"></i>
        </div>
        <div name="ddContent" onclick="{ onItemClick }" class="dd-content">
            <item each="{ item, index in opts.items }" class="{ selected: item === parent.selected }">{ item }</item>
        </div>
    </div>

    <script>
        console.log(opts);
        this.contentClickable = !!opts.contentClickable;
        this.selected = opts.selected || false;
        this._placeholder = opts.placeholder || 'Select...';
        this.placeholder = this.selected ? false : this._placeholder;

        this.onItemClick = function(event) {
            var t = event.target;
            while (t && !t.tagName.toUpperCase() == 'ITEM') t = t.parentElement

            if (t) {
                this.selected = t.textContent;
                this.update({ placeholder: this.selected ? false : this._placeholder })
            }
        }

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
        :scope { display: inline-block; text-transform: uppercase; }
        placeholder, selected-item { line-height: 2.4rem; padding: 0 0 0 0.8rem;  -webkit-touch-callout: none;
            -webkit-user-select: none; -khtml-user-select: none; -moz-user-select: none; -ms-user-select: none; }
        selected-item { display: inline-block; line-height: 2.4rem; }
        .dd { position: relative; display: inline-block; }
        .dd-trigger { border-radius: 4px; border-style: solid; border-width: 1px; box-sizing: border-box; cursor: pointer;
            font-size: 1.2rem; height: auto; letter-spacing: 0; line-height: 2.8rem; min-width: 3rem; padding:0;
            text-align: center; vertical-align: top; }
        .dd-trigger i { padding-left: 0.8rem; }
        .dd-trigger span { padding-left: 0.8rem; -webkit-touch-callout: none;
            -webkit-user-select: none; -khtml-user-select: none; -moz-user-select: none; -ms-user-select: none;
            user-select: none; }
        .dd-trigger i:only-child { padding: 0; }
        .dd-trigger placeholder + i, selected-item + i { padding-right: 0.8rem }
        .dd-content item { cursor: pointer; display: block; padding: 0.7rem 1rem; font-size: 1.2rem; text-transform: uppercase; }
        .dd-content { display: none; }
        .open .dd-content { display:block; }
    </style>

</iconic-select>
