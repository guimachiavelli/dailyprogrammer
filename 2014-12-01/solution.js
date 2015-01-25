(function(){

    'use strict';

    var fs = require('fs');


    function main() {
        var words = {};
        var file = fs.readFileSync('./data/pg47498.txt', {encoding: 'utf8'});

        file = file.toLowerCase()
                    .replace(/[^a-zA-Z0-9|\s]/g, '')
                    .replace(/[\s]/g, ' ')
                    .split(' ');


        file.forEach(function(word){
            if (words[word] === undefined) {
                words[word] = 0;
            }

            words[word] += 1;
        });
    }

    main();

}());
