function Style(element, original) {
    this.prop = {}
    this.element = element;
    this.isOriginal = original;

    if (original && element.__iconic_original_style === undefined) {
        this.prop = element.__iconic_original_style = {}
    } else if (original) {
        this.prop = element.__iconic_original_style
    }

    if (this.prop['all'] === undefined) {
        this._populate(element)
    }
}

Style.prototype._populate = function(element) {
    var styles = window.getComputedStyle(element)
    for (style in styles) {
        if (!parseInt(style, 10) && style != 0) {
            this.prop[style] = styles[style]
        }
    }
    this.prop.iconicInnerWidth = "" + element.scrollWidth + "px"
}

Style.prototype.update = function() {
    if (this.isOriginal) {
        throw Error("Won't update an original");
    }
    this._populate(this.element);
}

Style.prototype.get = function() {
    return this.prop;
}

Style.prototype.asInt = function(name) {
    return parseInt(this.prop[name], 10);
}

Style.prototype.asFloat = function(name) {
    return parseFloat(this.prop[name]);
}

Style.prototype.asString = function(name) {
    return this.prop[name];
}
