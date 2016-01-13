<iconic-announcement>
    <div class="loader">
        <svg xmlns="http://www.w3.org/2000/svg" version="1.1" width="7rem" height="7rem" viewbox="0 0 500 500">
            <path name="loader" transform="translate(250, 250) scale(4.2)"/>
        </svg>
    </div>
    <iconic-button class="close" onclick="{ hide }">&times;</iconic-button>
    <div class="badge">
        <i class="icon-announcement"></i>
    </div>
    <div class="content" onclick="{ wait }">
        <yield/>
    </div>

    <script>
        var DEFAULT_TIMEOUT = 10000,
            showing,
            drawing,
            angle = 0,
            interval,
            loader;

        function reset() {
            angle = 0
            loader.setAttribute( 'd', 'M 0 0 v -250 A 250 250 1 0 1 0 -250 z' )
        }

        function drawDeg(angle) {
            angle++
            angle %= 360;

            var r = ( angle * Math.PI / 180 ),
                x = Math.sin( r ) * 250,
                y = Math.cos( r ) * - 250,
                mid = ( angle > 180 ) ? 1 : 0,
                anim = 'M 0 0 v -250 A 250 250 1 ' + mid + ' 1 ' +  x  + ' ' +  y  + ' z';

            loader.setAttribute( 'd', anim )
        }

        function drawDegFromTo(angle, end) {
            //angle > end ? angle-- : angle ++;
            angle++
            angle %= end;

            console.log(angle, end);
            var r = ( angle * Math.PI / 180 ),
                x = Math.sin( r ) * 250,
                y = Math.cos( r ) * - 250,
                mid = ( angle > 180 ) ? 1 : 0,
                anim = 'M 0 0 v -250 A 250 250 1 ' + mid + ' 1 ' +  x  + ' ' +  y  + ' z';

            loader.setAttribute( 'd', anim )
            if (Math.abs(angle) <= 1) {
                clearTimeout(drawing);
                drawDeg(end);
            } else {
                drawing = setTimeout(function() {
                    drawDegFromTo(angle, end);
                }, 5);
            }
        }

        function drawProgress() {
            angle++;
            angle %= 360;
            var r = ( angle * Math.PI / 180 ),
                x = Math.sin( r ) * 250,
                y = Math.cos( r ) * - 250,
                mid = ( angle > 180 ) ? 1 : 0,
                anim = 'M 0 0 v -250 A 250 250 1 ' + mid + ' 1 ' +  x  + ' ' +  y  + ' z'
            loader.setAttribute( 'd', anim )
            if( angle != 0 ) {
                drawing = setTimeout(drawProgress, interval);
            }
        }

        this.wait = function() {
            reset()
            clearTimeout(drawing)
            clearTimeout(showing)
        }

        this.on('mount', function() {
            loader = this.loader;
            border = this.border;
        });

        this.show = function(timeout) {
            this.hide();
            interval = Math.floor((parseInt(timeout - 250, 10) || DEFAULT_TIMEOUT - 250) / 360);
            this.root.classList.add('show')
            if (timeout) {
                this.loader.style.display = 'block';
                reset()
                clearTimeout(drawing)
                clearTimeout(showing)
                drawProgress();
                showing = setTimeout(function() {
                    this.hide();
                }.bind(this), timeout || DEFAULT_TIMEOUT);
            } else {
                this.loader.style.display = 'none';
            }
        }.bind(this)

        this.hide = function() {
            reset();
            clearTimeout(drawing)
            clearTimeout(showing)
            this.root.classList.remove('show')
        }.bind(this)


    </script>

    <style scoped>
        :scope {
            display: block;
            position: fixed;
            top: -16rem;
            left: 0;
            right: 0;
            height: 8rem;
            transition: all 300ms ease-in-out;
            overflow: hidden;
            z-index: 200;
        }

        :scope.show {
            top: 0rem;
        }

        .close {
            color: rgba(255,255,255,0.6);
            float: right;
            width: 8rem;
            height: 8rem;
            border: none;
        }

        .close:hover {
            color: rgba(255,255,255,0.6);
        }

        .close div[name="text"] {
            font-weight: 600;
            font-size: 10rem;
            line-height: 5.5rem;
        }

        .badge {
            padding: 1rem;
            position: relative;
            height: 6rem;
            width: 6rem;
            font-size: 6rem;
            line-height: 5rem;
        }

        .content {
            position: absolute;
            height: 6rem;
            top: 0rem;
            left: 8rem;
            width: auto;
            right: 8rem;
            font-size: 1.8rem;
            font-weight: bolder;
            padding:1rem;
            display: table-cell;
            vertical-align: middle;
        }

        .loader {
            padding: 0.5rem;
            position: absolute;
            top: 0;
            right: 0;
            height: 7rem;
            width: 7rem;
        }

        path[name="loader"] {
            fill: rgba(0, 0, 0, 0.5);
        }
    </style>
</iconic-announcement>
