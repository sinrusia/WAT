/**
 * Created by gojaehag on 2015. 10. 26..
 */
var dwServices = angular.module('dwServices', []);

dwServices.factory('appService', function() {
    var smb_id;

    var getSmbId = function() {
        return smb_id;
    }

    var setSmbId= function(value) {
        smb_id = value;
    }

    return {
        getSmbId: getSmbId,
        setSmbId: setSmbId
    };
})