describe('Riot Tag Specs', function () {
    var element;

    beforeEach(function () {
        element = document.createElement('iconic-navigation');
        element.setAttribute('data-fixed', 'left');
        element.setAttribute('data-effect', 'slide');
        document.body.innerHTML = '';
        document.body.appendChild(element);
    })

    //document.querySelector('iconic-navigation')
    it('mounts the tag', function () {
        var navs = riot.mount('iconic-navigation');
        expect(navs.length).to.be(1)
    })
})
