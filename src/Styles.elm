module Styles
    exposing
        ( controlButton
        , controlIcon
        , controlIconBackground
        , controlPanel
        , controlPanelContent
        , controls
        , logo
        , logoImage
        , logoImageBackground
        , playerGifContainer
        , trackInfo
        , videoPlayer
        )

import Css
    exposing
        ( Style
        , absolute
        , auto
        , backgroundColor
        , backgroundImage
        , backgroundPosition2
        , backgroundRepeat
        , backgroundSize
        , block
        , border
        , border3
        , borderBox
        , boxShadow4
        , boxSizing
        , center
        , color
        , cursor
        , default
        , display
        , double
        , fixed
        , float
        , fontSize
        , height
        , int
        , lastChild
        , left
        , lineHeight
        , linearGradient2
        , marginBottom
        , marginRight
        , marginTop
        , minHeight
        , minWidth
        , none
        , noRepeat
        , padding
        , pct
        , pointer
        , pointerEvents
        , position
        , property
        , px
        , relative
        , repeat
        , rgb
        , rgba
        , stop2
        , textAlign
        , textShadow4
        , toBottom
        , top
        , transparent
        , url
        , width
        , zIndex
        )
import Css.Foreign exposing (children, div)


controlButton : Style
controlButton =
    Css.batch
        [ backgroundColor (rgba 0 0 0 0.2)
        , boxSizing borderBox
        , controlPanelItemBorder
        , cursor pointer
        , display block
        , float left
        , height (px 44)
        , lineHeight (px 40)
        , marginRight (px 8)
        , position relative
        , textAlign center
        , width (px 44)
        ]


controlIcon : Style
controlIcon =
    Css.batch
        [ backgroundImage
            (linearGradient2
                toBottom
                (stop2 (rgba 241 231 103 1.0) (pct 0))
                (stop2 (rgba 254 182 69 1.0) (pct 50))
                [ (stop2 (rgba 241 231 103 1.0) (pct 100)) ]
            )
        , color (rgb 255 255 255)
        , fontSize (px 18)
        , property "-webkit-background-clip" "text"
        , property "background-clip" "text"
        , property "-webkit-text-fill-color" "transparent"
        , property "text-fill-color" "transparent"
        , textShadow4 (px 0) (px 0) (px 10) (rgba 241 231 103 1.0)
        ]


controlIconBackground : Style
controlIconBackground =
    Css.batch
        [ scanlines 44 44 ]


controlPanel : Style
controlPanel =
    Css.batch
        [ display block
        , height (pct 100)
        , position fixed
        , left (px 0)
        , top (px 0)
        , width (px 220)
        , zIndex (int 5000)
        ]


controlPanelContent : Style
controlPanelContent =
    Css.batch
        [ boxSizing borderBox
        , cursor default
        , height (pct 100)
        , padding (px 10)
        , position relative
        , top (px 0)
        , width (px 220)
        ]


controlPanelItemBorder : Style
controlPanelItemBorder =
    let
        miamiBlue =
            rgb 102 200 255
    in
        Css.batch
            [ border3 (px 3) double miamiBlue
            , boxShadow4 (px 0) (px 0) (px 12) miamiBlue
            ]


controls : Style
controls =
    children
        [ div
            [ lastChild
                [ marginRight (px 0) ]
            ]
        ]


logo : Style
logo =
    Css.batch
        [ backgroundColor transparent
        , backgroundImage (url "http://i.giphy.com/yrIRi67zxPmo.gif")
        , backgroundPosition2 (px 0) (px -40)
        , backgroundRepeat noRepeat
        , backgroundSize (pct 101)
        , boxSizing borderBox
        , controlPanelItemBorder
        , height (px 120)
        , marginBottom (px 20)
        , position relative
        , textAlign center
        , width (px 200)
        ]


logoImage : Style
logoImage =
    Css.batch
        [ border (px 0)
        , height (pct 90)
        , marginTop (pct 5)
        ]


logoImageBackground : Style
logoImageBackground =
    scanlines 120 200


playerGifContainer : Int -> Style
playerGifContainer zindex =
    Css.batch
        [ height (pct 100)
        , left (px 0)
        , position fixed
        , textAlign center
        , top (px 0)
        , width (pct 100)
        , zIndex (int zindex)
        ]


trackInfo : Style
trackInfo =
    Css.batch
        [ backgroundColor (rgba 0 0 0 0.2)
        , boxSizing borderBox
        , color (rgb 255 255 255)
        , controlPanelItemBorder
        , height (px 126)
        , marginBottom (px 8)
        , position relative
        , textAlign center
        ]


videoPlayer : Style
videoPlayer =
    Css.batch
        [ height auto
        , minHeight (pct 100)
        , minWidth (pct 100)
        , width auto
        , zIndex (int -100)
        ]



---- PRIVATE ----


scanlines : Float -> Float -> Style
scanlines pxHeight pxWidth =
    Css.batch
        [ backgroundImage (url "assets/scanline-overlay.png")
        , backgroundRepeat repeat
        , display block
        , height (px pxHeight)
        , left (px -2)
        , pointerEvents none
        , position absolute
        , top (px -2)
        , width (px pxWidth)
        , zIndex (int 50000)
        ]
