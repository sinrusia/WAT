/**
 * Created by gojaehag on 2015. 10. 7..
 */
(function (window, document) {
    var ssd = window.ssd || (window.ssd = {});

    ssd.generateUUID = function () {
        var d = new Date().getTime();
        var uuid = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
            var r = (d + Math.random() * 16) % 16 | 0;
            d = Math.floor(d / 16);
            return (c == 'x' ? r : (r & 0x3 | 0x8)).toString(16);
        });
        return uuid;
    };

    if ($.generateUUID === undefined) {
        $.generateUUID = ssd.generateUUID;
    }

})(window, document);
