module ControlPanel.Animations exposing (hidden, visible)

import Animation exposing (Property, px)


hidden : List Property
hidden =
    [ Animation.left (px -220.0) ]


visible : List Property
visible =
    [ Animation.left (px 0.0) ]
