module ControlPanel.Styles
    exposing
        ( content
        , controlPanel
        , logo
        , logoImage
        , logoImageBackground
        , trackInfo
        )

import Css
    exposing
        ( Color
        , Style
        , absolute
          -- , after
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
          -- , borderRadius
          -- , both
        , boxShadow4
        , boxSizing
        , center
        , color
          -- , content
        , cursor
        , default
        , display
        , double
        , fixed
          -- , float
          -- , focus
          -- , fontFamilies
        , fontSize
        , height
          -- , hover
        , int
          -- , lastChild
        , left
          -- , lineHeight
          -- , linearGradient2
        , marginBottom
          -- , marginLeft
          -- , marginRight
        , marginTop
          -- , minHeight
          -- , minWidth
        , none
        , noRepeat
          -- , outline
        , overflow
        , padding
        , pct
          -- , pointer
        , pointerEvents
        , position
          -- , property
          -- , pseudoElement
        , px
        , relative
        , repeat
        , rgb
        , rgba
          -- , solid
          -- , stop2
        , textAlign
          -- , textDecoration
          -- , textShadow4
          -- , textTransform
          -- , toBottom
        , top
        , transparent
          -- , uppercase
        , url
        , width
        , zIndex
        )


-- import Css.Foreign exposing (children, div)


content : Style
content =
    Css.batch
        [ boxSizing borderBox
        , cursor default
        , height (pct 100)
        , padding (px 10)
        , position relative
        , top (px 0)
        , width (px 220)
        ]


controlPanel : Style
controlPanel =
    Css.batch
        [ display block
        , fontSize (px 14)
        , height (pct 100)
        , position fixed
        , left (px 0)
        , overflow auto
        , top (px 0)
        , width (px 220)
        , zIndex (int 5000)
        ]


logo : Style
logo =
    Css.batch
        [ backgroundColor transparent
        , backgroundImage (url "http://i.giphy.com/yrIRi67zxPmo.gif")
        , backgroundPosition2 (px 0) (px -40)
        , backgroundRepeat noRepeat
        , backgroundSize (pct 101)
        , blueBorder
        , boxSizing borderBox
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
    scanlines (px 120) (px 200) (px -2)


trackInfo : Style
trackInfo =
    Css.batch
        [ backgroundColor (rgba 0 0 0 0.2)
        , blueBorder
        , boxSizing borderBox
        , color (rgb 255 255 255)
        , height (px 126)
        , marginBottom (px 8)
        , position relative
        , textAlign center
        ]


blueBorder : Style
blueBorder =
    Css.batch
        [ border3 (px 3) double miamiBlue
        , boxShadow4 (px 0) (px 0) (px 12) miamiBlue
        ]


scanlines :
    Css.LengthOrAuto compatible
    -> Css.LengthOrAuto compatible1
    -> Css.LengthOrAuto compatible2
    -> Style
scanlines linesHeight linesWidth positioning =
    Css.batch
        [ backgroundImage (url "assets/scanline-overlay.png")
        , backgroundRepeat repeat
        , display block
        , height linesHeight
        , left positioning
        , pointerEvents none
        , position absolute
        , top positioning
        , width linesWidth
        , zIndex (int 50000)
        ]


miamiBlue : Color
miamiBlue =
    rgb 102 200 255
