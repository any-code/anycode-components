describe('Riot Tag Specs', function () {
    var element;

    beforeEach(function () {
        element = document.createElement('iconic-navigation');
        document.body.innerHTML = '';
        document.body.appendChild(element);
    })

    it('mounts the tag', function () {
        riot.mount('anycode-components')
        expect(document.querySelector('iconic-navigation')).to.be.ok()
    })
})
