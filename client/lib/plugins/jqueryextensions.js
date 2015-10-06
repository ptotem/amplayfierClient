$.fn.rotationInfo = function() {
    var el = $(this),
        tr = el.css("-webkit-transform") || el.css("-moz-transform") || el.css("-ms-transform") || el.css("-o-transform") || '',
        info = {rad: 0, deg: 0};
    if (tr = tr.match('matrix\\((.*)\\)')) {
        tr = tr[1].split(',');
        if(typeof tr[0] != 'undefined' && typeof tr[1] != 'undefined') {
            info.rad = Math.atan2(tr[1], tr[0]);
            info.deg = parseFloat((info.rad * 180 / Math.PI).toFixed(1));
        }
    }
    return info;
};
//small js function to covert any form to a json objects with keys as 'name' of input field and 'value' as what users enter!
    $.fn.serializeObject = function () {
        var o = {};
        var a = this.serializeArray();
        $.each(a, function () {
            if (o[this.name] !== undefined) {
                if (!o[this.name].push) {
                    o[this.name] = [o[this.name]];
                }
                o[this.name].push(this.value || '');
            } else {
                o[this.name] = this.value || '';
            }
        });
        return o;
    };

$.fn.serializeObjectClone = function () {
    var o = {};
    var a = this.serializeArray();
    $.each(a, function () {

        if (o[this.name] !== undefined) {
            if (!o[this.name].push) {

                if(this.name.indexOf(".") === -1)
                    o[this.name] = this.value;
                else {

                    pkey = this.name.split(".")[0];
                    ckey = this.name.split(".")[1];
                    if(o[pkey]===undefined)
                        o[pkey]=  {};
                    o[pkey][ckey] = this.value;
                }
            }
            o[this.name].push(this.value || '');
        } else {
            if(this.name.indexOf(".") === -1)
                o[this.name] = this.value;
            else {
                pkey = this.name.split(".")[0];
                ckey = this.name.split(".")[1];
                if(o[pkey]===undefined)
                    o[pkey]=  {};
                o[pkey][ckey] = this.value;
            }
        }
    });
    return o;
};

$.fn.swapClass = function (a, b) {
    $(this).removeClass(a).addClass(b)
};
$.fn.selectRange = function(start, end) {
    return this.each(function() {
        if(this.setSelectionRange) {
            this.focus();
            this.setSelectionRange(start, end);
        } else if(this.createTextRange) {
            var range = this.createTextRange();
            range.collapse(true);
            range.moveEnd('character', end);
            range.moveStart('character', start);
            range.select();
        }
    });
};

$.fn.textfill = function(options) {
    var fontSize = options.maxFontPixels;
    var ourText = $('span:visible:first', this);
    var maxHeight = $(this).height();
    console.log("maxHeight: " + maxHeight);
    var maxWidth = $(this).width();
    console.log("maxWidth: " + maxWidth);
    var textHeight;
    var textWidth;
    do {
            ourText.css('font-size', fontSize);
            textHeight = ourText.height();
            textWidth = ourText.width();
            fontSize = fontSize - 1;
    } while (textHeight > maxHeight || textWidth > maxWidth && fontSize > 3);
    ourText.css('line-height', (fontSize + 2) + "px");
    console.log("textHeight: " + textHeight);
    console.log("textWidth: " + textWidth);
    console.log("fontSize: " + fontSize);
    return this;
};
