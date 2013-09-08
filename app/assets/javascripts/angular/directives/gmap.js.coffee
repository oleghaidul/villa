App.directive("gmap", ->
  scope:
    gmap: '@'
  link: (scope, element, attributes) ->
    scope.$watch "gmap", (address) ->
      $(element).gMap
        markers: [
          address: address
          html: address
          popup: true
        ]
        address: address
        zoom: 15
        controls: false
        scrollwheel: true
)