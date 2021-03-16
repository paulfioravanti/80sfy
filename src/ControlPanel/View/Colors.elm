module ControlPanel.View.Colors exposing
    ( background
    , black
    , blue
    , paleYellow
    , pastelOrange
    , white
    , whiteWithAlpha
    , yellow
    , yellowWithAlpha
    )

import Css exposing (Color, rgb, rgba)


background : Color
background =
    rgba 0 0 0 0.2


black : Color
black =
    rgb 0 0 0


blue : Color
blue =
    rgb 102 200 255


paleYellow : Color
paleYellow =
    rgba 243 235 126 0.49


pastelOrange : Color
pastelOrange =
    rgb 254 182 69


white : Color
white =
    rgb 255 255 255


whiteWithAlpha : Float -> Color
whiteWithAlpha alpha =
    rgba 255 255 255 alpha


yellow : Color
yellow =
    rgb 241 231 103


yellowWithAlpha : Float -> Color
yellowWithAlpha alpha =
    rgba 241 231 103 alpha
