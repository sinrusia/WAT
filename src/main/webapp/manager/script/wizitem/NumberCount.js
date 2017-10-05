/**
 * Created by gojaehag on 2015. 10. 7..
 */
/**
 *
 */
(function(ssd){
    /**
     *
     * @param $scope
     */
    ssd.NumberCount = function($scope) {
        function openList() {
            window.open('/xefc/jsp/ui/main.jsp?m_id=802010&uri=/xefc/jsp/ui/appr/appr_multiappr.jsp');
            //alert('extends');
        }

        $scope.setValue = function() {
            openList();
            //$scope.value = 99;
        }

        $scope.change = function() {
            //console.log('changeValue');
        }
    }
})(ssd);