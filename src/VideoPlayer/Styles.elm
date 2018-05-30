module VideoPlayer.Styles exposing (gifContainer, videoPlayer)

import Css
    exposing
        ( Style
        , auto
        , center
        , fixed
        , height
        , int
        , left
        , minHeight
        , minWidth
        , pct
        , position
        , px
        , textAlign
        , top
        , width
        , zIndex
        )


gifContainer : Int -> Style
gifContainer zindex =
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
