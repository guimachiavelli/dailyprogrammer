(function() {
    'use strict';

    var acronyms = {
        lol    : 'laugh out loud',
        dw     : 'don\'t worry',
        hf     : 'have fun',
        gg     : 'good game',
        brb    : 'be right back',
        g2g    : 'got to go',
        wtf    : 'what the fuck',
        wp     : 'well played',
        gl     : 'good luck',
        imo    : 'in my opinion',
        idk    : 'I do not know'
    };

    function main(text) {
        text = text || 'something, something, imo, no way';

        Object.keys(acronyms).forEach(function(key){
            text = text.replace(key, acronyms[key]);
        });

        console.log(text);
    }


    if (require.main === module) {
        var args = process.argv.slice(2);

        main(args[0]);
    }

}());
