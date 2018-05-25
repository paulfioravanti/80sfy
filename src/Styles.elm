module Styles
    exposing
        ( controlPanel
        , controlPanelContent
        , logo
        , logoImage
        , playerGifContainer
        , scanlines
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
        , cursor
        , default
        , display
        , double
        , fixed
        , height
        , int
        , left
        , marginBottom
        , marginTop
        , minHeight
        , minWidth
        , none
        , noRepeat
        , padding
        , pct
        , pointerEvents
        , position
        , px
        , relative
        , repeat
        , rgb
        , textAlign
        , top
        , transparent
        , url
        , width
        , zIndex
        )


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


logo : Style
logo =
    Css.batch
        [ backgroundColor transparent
        , backgroundImage (url "http://i.giphy.com/yrIRi67zxPmo.gif")
        , backgroundPosition2 (px 0) (px -40)
        , backgroundRepeat noRepeat
        , backgroundSize (pct 101)
        , border3 (px 3) double (rgb 102 200 255)
        , boxShadow4 (px 0) (px 0) (px 12) (rgb 102 200 255)
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


scanlines : Style
scanlines =
    Css.batch
        [ backgroundImage (url "assets/scanline-overlay.png")
        , backgroundRepeat repeat
        , display block
        , height (px 120)
        , left (px -2)
        , pointerEvents none
        , position absolute
        , top (px -2)
        , width (px 200)
        , zIndex (int 50000)
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
