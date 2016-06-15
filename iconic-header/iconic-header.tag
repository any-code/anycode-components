<iconic-header>
    <div>
        <yield/>
    <div>

    <style scoped>
        :scope { display: block; height: 4.2rem; padding: 0; transition: all 200ms ease-in-out; white-space: nowrap; }
        :scope div > ul { margin: 0; padding: 0; }
        :scope div > ul li { list-style: none; margin: 0; padding: 0 0.5rem 0 0; }
        :scope div > ul li.pinned, :scope div > ul li.restricted { margin-top: 0.8rem; }
        :scope div > ul li * { margin-top: -2px; }
        :scope div > ul li a { margin-top: 0px; padding-top: 3px; display: block; font-size: 1.4rem; padding: 0.8rem 0.8rem 0 0.8rem; text-align: left;
            text-decoration: none; transition: all 80ms ease-in-out; }
        :scope div > ul li a.button { margin-top: -2px; padding-top: 0; }

        :scope div > ul li.separator { width: 0.6rem; }
    </style>

</iconic-header>
