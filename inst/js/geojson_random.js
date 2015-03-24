(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
(function (global){
global.georandom = require('geojson-random');

}).call(this,typeof global !== "undefined" ? global : typeof self !== "undefined" ? self : typeof window !== "undefined" ? window : {})
},{"geojson-random":2}],2:[function(require,module,exports){
module.exports = function() {
    throw new Error('call .point() or .polygon() instead');
};

function position(bbox) {
    if (bbox) return coordInBBBOX(bbox);
    else return [lon(), lat()];
}

module.exports.position = position;

module.exports.point = function(count, bbox) {
    var features = [];
    for (i = 0; i < count; i++) {
        features.push(feature(bbox ? point(position(bbox)) : point()));
    }
    return collection(features);
};

module.exports.polygon = function(count, num_vertices, max_radial_length, bbox) {
    if (typeof num_vertices !== 'number') num_vertices = 10;
    if (typeof max_radial_length !== 'number') max_radial_length = 10;
    var features = [];
    for (i = 0; i < count; i++) {
        var vertices = [],
            circle_offsets = Array.apply(null,
                new Array(num_vertices + 1)).map(Math.random);

        circle_offsets.forEach(sumOffsets);
        circle_offsets.forEach(scaleOffsets);
        vertices[vertices.length - 1] = vertices[0]; // close the ring

        // center the polygon around something
        vertices = vertices.map(vertexToCoordinate(position(bbox)));
        features.push(feature(polygon([vertices])));
    }

    function sumOffsets(cur, index, arr) {
        arr[index] = (index > 0) ? cur + arr[index - 1] : cur;
    }

    function scaleOffsets(cur, index) {
        cur = cur * 2 * Math.PI / circle_offsets[circle_offsets.length - 1];
        var radial_scaler = Math.random();
        vertices.push([
            radial_scaler * max_radial_length * Math.sin(cur),
            radial_scaler * max_radial_length * Math.cos(cur)
        ]);
    }

    return collection(features);
};


function vertexToCoordinate(hub) {
    return function(cur, index) { return [cur[0] + hub[0], cur[1] + hub[1]]; };
}

function rnd() { return Math.random() - 0.5; }
function lon() { return rnd() * 360; }
function lat() { return rnd() * 180; }

function point(coordinates) {
    return {
        type: 'Point',
        coordinates: coordinates || [lon(), lat()]
    };
}

function coordInBBBOX(bbox) {
    return [
        (Math.random() * (bbox[2] - bbox[0])) + bbox[0],
        (Math.random() * (bbox[3] - bbox[1])) + bbox[1]];
}

function pointInBBBOX() {
    return {
        type: 'Point',
        coordinates: [lon(), lat()]
    };
}

function polygon(coordinates) {
    return {
        type: 'Polygon',
        coordinates: coordinates
    };
}

function feature(geom) {
    return {
        type: 'Feature',
        geometry: geom,
        properties: {}
    };
}

function collection(f) {
    return {
        type: 'FeatureCollection',
        features: f
    };
}

},{}]},{},[1]);
