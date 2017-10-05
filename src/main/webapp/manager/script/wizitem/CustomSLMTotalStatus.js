/**
 * Created by gojaehag on 2015. 10. 7..
 */

/**
 * ssd uiitem 확장 모듈
 */
(function(ssd){

    /**
     * ssd에 확장 모듈을 정의한다
     * @param $scope
     * @constructor
     */
    ssd.CustomSLMTotalStatus = function($scope) {

        /**
         *
         */
        $scope.update = function() {
            showme();
        }

        /**
         *
         */
        function showme(){
            alert('show me' + this);
        }
    }
})(ssd)