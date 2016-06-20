<iconic-tagger>

    <div name="dd" class="dd">
        <div name="ddTrigger" onclick="{ onTriggerClick }" class="dd-trigger opener u-nd">
            <items name="selectedNode">
                <span each="{ item, index in selected }">{ item }</span>
            </items>
            <placeholder if="{ placeholder }" >{ placeholder }</placeholder>
            <i class="icon-add opener"></i>
        </div>
        <div name="ddContent" onclick="{ onItemClick }" class="dd-content">
            <item class="interactive" each="{ item, index in unused }">{ item }</item>
        </div>
    </div>

    <script>
        this.contentClickable = !!opts.contentClickable;
        this._placeholder = opts.placeholder || 'All...';
        this.items = opts.items || [];
        this.selected = opts.selected ? opts.selected.split(',') : [];
        this.unused = [].concat(this.items);
        this.placeholder = this.selected.length > 0 ? false : this._placeholder;

        this.onItemClick = function(event) {
            var t = event.target;
            while (t && !t.tagName.toUpperCase() == 'ITEM') t = t.parentElement

            if (t) {
                var el = document.createElement('span'),
                    text = document.createTextNode(t.textContent);
                el.appendChild(text);

                this.selected.push(t.textContent);

                if (this.selected.length > 0) { this.update({ placeholder: false }) }

                this.ddContent.removeChild(t);

                var itemList = this.ddContent.querySelectorAll('item');
                if (itemList.length == 0) {
                    this.ddTrigger.classList.add('disabled');
                    this.dd.classList.remove("open")
                }

                var sort = this.selectedNode.childNodes,
                    sArr = [].slice.call(sort).sort(function (a, b) {
                        return a.textContent > b.textContent ? 1 : -1
                    })

                sArr.forEach(function (n) {
                    this.selectedNode.appendChild(n);
                }.bind(this));
            }
        }

        this.onTriggerClick = function(event) {
            if (event.target.tagName.toUpperCase() == 'SPAN') {
                this.unused.push(event.target.textContent);
                this.ddTrigger.classList.remove('disabled');

                if (this.selected.length > 0) { this.update({ placeholder: false }) }

                if (this.selected.indexOf(event.target.textContent) > -1) {
                    var selected = [].concat(this.selected);
                    selected.splice(selected.indexOf(event.target.textContent), 1);
                    this.update({
                        selected: selected
                    })
                }

                if (this.selected.length == 0) {
                    this.update({
                        placeholder: this._placeholder
                    })
                }

                var sort = this.ddContent.childNodes,
                    sArr = [].slice.call(sort).sort(function (a, b) {
                        return a.textContent > b.textContent ? 1 : -1
                    })

                sArr.forEach(function (n) {
                    this.ddContent.appendChild(n);
                }.bind(this));

                return;
            }

            if (this.ddContent.querySelectorAll('item').length == 0) return;

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
        .dd-trigger .opener { margin-top: 0; font-size: 1rem; }
        .dd-trigger i:only-child { padding: 0; }
        .dd-trigger i + span { padding-left: 0.5rem; padding-right: 0.8rem }
        .dd-trigger items + i { padding-right: 0.8rem }
        .dd-trigger placeholder + i { padding-right: 0.8rem }
        .dd-content item { cursor: pointer; display: block; padding: 0.7rem 1rem; font-size: 1.2rem; text-transform: uppercase; white-space: nowrap; padding-top:0.5rem; padding-bottom:0.5rem; }
        .dd-content { display: none; }
        .open .dd-content { display:block; }
    </style>

</iconic-tagger>
