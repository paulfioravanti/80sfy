module Styles exposing (controlPanel, playerGifContainer, videoPlayer)

import Css
    exposing
        ( Style
        , auto
        , block
        , center
        , display
        , fixed
        , height
        , int
        , left
        , minHeight
        , minWidth
        , pct
        , position
        , px
        , rgb
        , textAlign
        , top
        , width
        , zIndex
          -- tmp
        , backgroundColor
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
          -- tmp
        , backgroundColor (rgb 255 0 0)
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


videoPlayer : Style
videoPlayer =
    Css.batch
        [ height auto
        , minHeight (pct 100)
        , minWidth (pct 100)
        , width auto
        , zIndex (int -100)
        ]
