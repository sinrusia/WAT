/**
 * Created by gojaehag on 2015. 11. 24..
 */

var ssdFilters = angular.module('ssdFilters', []);

ssdFilters.filter('dateFormatter', function() {
    return function(input) {
        var pastDay = new Date(input);

        return pastDay.getFullYear() + '년 ' + pastDay.getMonth()+1 + '월 ' + pastDay.getDate() + '일';
    };
});

ssdFilters.filter('numberOfPastday', function() {
    return function(input) {
        var pastDay = new Date(input);
        var today = new Date();

        var day = parseInt((today.getTime() - pastDay.getTime())/1000/60/60/24);

        return day;
    };
})