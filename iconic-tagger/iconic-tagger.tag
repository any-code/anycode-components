<iconic-tagger>

    <div name="dd" class="dd">
        <div name="ddTrigger" onclick="{ onTriggerClick }" class="dd-trigger opener u-nd">
            <items name="selectedNode">
                <span each="{ item, index in selected }">{ item }</span>
            </items>
            <placeholder if="{ placeholder }" >{ placeholder }</placeholder>
            <i class="{ opts.icon } opener"></i>
        </div>
        <div name="ddContent" onclick="{ onItemClick }" class="dd-content">
            <item class="interactive" each="{ item, index in unselected }">{ item }</item>
        </div>
    </div>

    <script>
        function inside(index) { return index > -1 }
        function outside(index) { return index === -1 }
        function pick(checkList, items, fn) {
            var list = [];
            items.forEach(function(item) {
                if (fn(checkList.indexOf(item)))
                    list.push(item);
            })
            list.sort(function (a, b) { return a > b ? 1 : -1 })
            return list
        }
        function move(from, to, name) {
            var names = name && typeof name == "string" ? [name] : name
            names.forEach(function(name) {
                var fi = from.indexOf(name)
                if (fi > -1) from.splice(fi, 1)
                if (to.indexOf(name) === -1) to.push(name)
            })
            from.sort(function (a, b) { return a > b ? 1 : -1 })
            to.sort(function (a, b) { return a > b ? 1 : -1 })
            return to
        }

        this.setSelected = function(list) {
            var unselected = [].concat(this.selected, this.unselected)
            this.update({
                selected: move([], [], pick(list, unselected, inside)),
                unselected: move([], [], pick(list, unselected, outside))
            })

            this.draw()
        }

        this.setItems = function(list) {
            this.update({
                selected: move([], [], pick(this.selected, list, inside)),
                unselected: move([], [], pick(this.selected, list, outside))
            })

            this.draw()
        }

        this.on('set-selected', this.setSelected)
        this.on('set-items', this.setItems)

        // clicking a dropdown list item
        this.onItemClick = function(event) {
            var t = event.target

            // find the clicked item
            while (t && !t.tagName.toUpperCase() == 'ITEM') t = t.parentElement
            if (!t) return

            move(this.unselected, this.selected, t.textContent);

            this.draw()

            this.update({ placeholder: this.selected.length === 0 ? this._placeholder : false })
        }

        // clicking on a selected tag
        this.onSelectedTagClick = function(event) {
            if (event.target.tagName.toUpperCase() != 'SPAN') return false
            move(this.selected, this.unselected, event.target.textContent)

            this.draw()

            return true
        }

        this.draw = function() {
            if (this.unselected.length === 0) {
                this.ddTrigger.classList.add('disabled')
                this.dd.classList.remove("open")
            } else {
                this.ddTrigger.classList.remove('disabled')
            }

            this.update({ placeholder: this.selected.length === 0 ? this._placeholder : false })
        }

        this.onTriggerClick = function(event) {
            // don't show the list if the user
            // clicked a tag or the list is empty
            if (this.onSelectedTagClick(event) || this.unselected.length == 0) return;

            // set the width of the dropdown to be
            // at least the width of the trigger
            this.ddContent.style.minWidth = (this.ddTrigger.clientWidth) + 'px'

            // toggle the dropdown
            this.dd.classList.toggle("open")

            // add oversize class if dropdown width is
            // actually greater than the trigger width
            this.ddTrigger.clientWidth < this.ddContent.clientWidth ?
                this.dd.classList.add('oversize') : this.dd.classList.remove('oversize')
        }.bind(this)

        this.onWindowClick = function(event) {
            // find the trigger element of the event target if it has one
            var t = event.target,
                c = event.target

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

            this.update({
                selected: move([], [], pick(opts.selected, opts.items, inside)),
                unselected: move([], [], pick(opts.selected, opts.items, outside))
            })

            this._placeholder = opts.placeholder || 'All...'
            this.draw()
        })

        this.on('unmount', function() {
            // when the tag is unmounted kill the window click event listener
            window.removeEventListener('click', this.onWindowClick.bind(this), false)
        })

    </script>

    <style scoped>
        :scope { display: inline-block; text-transform: uppercase; }
        placeholder { padding: 0 0 0 0.8rem; line-height: 2.4rem; -webkit-touch-callout: none;
            -webkit-user-select: none; -khtml-user-select: none; -moz-user-select: none; -ms-user-select: none; }
        .dd-trigger items { max-width: 26rem; white-space: normal; display: inline-block; position: relative;
            text-align: left; line-height: 2.4rem; }
        .dd { position: relative; display: inline-block; }
        .dd-trigger { border-radius: 4px; border-style: solid; border-width: 1px; box-sizing: border-box; cursor: pointer;
            font-size: 1.2rem; height: auto; letter-spacing: 0; line-height: 2.8rem; min-width: 3rem; padding:0;
            text-align: center; vertical-align: top;
        }
        .dd-trigger i { padding-left: 0.8rem; line-height: 0; }
        .dd-trigger span { -webkit-touch-callout: none; -webkit-user-select: none; -khtml-user-select: none;
            -moz-user-select: none; -ms-user-select: none; user-select: none; border-radius: 0.3rem; white-space: nowrap;
            margin: 0.2rem; padding: 0rem 0.4rem; display: inline-block; line-height: 1.8rem;
        }
        .dd-trigger span:after { content: "\00D7"; font-size: 1.8rem; margin-left: 0.3rem; display: inline-block;
            line-height: 0;}
        .dd-trigger i:only-child { padding: 0; }
        .dd-trigger i + span { padding-left: 0.5rem; padding-right: 0.8rem }
        .dd-trigger items + i { padding-right: 0.8rem }
        .dd-trigger placeholder + i { padding-right: 0.8rem }
        .dd-content item { cursor: pointer; display: block; padding: 0.7rem 1rem; font-size: 1.2rem; text-transform: uppercase; white-space: nowrap; padding-top:0.5rem; padding-bottom:0.5rem; }
        .dd-content { display: none; }
        .open .dd-content { display:block; }
    </style>

</iconic-tagger>
