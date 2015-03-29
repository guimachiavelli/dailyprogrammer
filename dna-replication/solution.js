/* jshint node: true */

'use strict';

var fs = require('fs');
var pairs;

pairs = {
    A: 'T',
    T: 'A',
    G: 'G',
    C: 'G'
};

function getPairAmount() {
    var codons;
    codons = Math.floor(Math.random() * 10) + 3;

    // multiply by three since codons are groups of three bases
    return codons * 3;
}

function getRandomBase() {
    return Object.keys(pairs)[Math.floor(Math.random() * 4)];
}

function loadCodonTable() {
    return JSON.parse(fs.readFileSync('./codon-names.json',
                                      {enconding: 'utf-8'}));
}

function sealStrand(strand, codonTable) {
    var lastCodon;
    lastCodon = strand.slice(-3).join('');

    if (codonTable[lastCodon] === 'STOP') {
        return strand;
    }

    strand.push('T', 'A', 'A');

    return strand;
}

function generateStrand(length, codonTable) {
    var strand, codon;

    strand = ['A', 'T', 'G'];

    while (length > 0) {
        codon = length % 3 === 0 ? '' : codon;

        strand.push(getRandomBase());
        codon += strand.slice(-1);

        if (codonTable[codon] === 'STOP') {
            break;
        }

        length -= 1;
    }

    return sealStrand(strand, codonTable);
}

function getCodonNames(strand, codonTable) {
    var names, codon, i, len;

    names = [];

    for (i = 0, len = strand.length; i < len; i += 1) {
        if (i % 3 === 0) {
            names.push(codonTable[codon]);
            codon = '';
        }

        codon += strand[i];

        if (i === len - 1) {
            names.push(codonTable[codon]);
        }
    }

    return names;
}

function log(strand1, codonList, strand2) {
    console.log('generated strand:');
    console.log(strand1.join(' '));

    console.log('protein names:');
    console.log(codonList.join(' '));

    console.log('complimentary strand:');
    console.log(strand2.join(' '));
}

function main() {
    var length, strand1, strand2, codonTable, codonList;

    strand1 = [];
    strand2 = [];

    codonTable = loadCodonTable();
    length = getPairAmount();

    strand1 = generateStrand(length, codonTable);

    strand2 = strand1.map(function(base) {
        return pairs[base];
    });

    codonList = getCodonNames(strand1, codonTable);

    log(strand1, codonList, strand2);
}

main();
