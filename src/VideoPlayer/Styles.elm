module VideoPlayer.Styles exposing
    ( gifContainer
    , videoPlayer
    , videoPlayerPaused
    , videoPlayerPausedContent
    )

import Css
    exposing
        ( Style
        , absolute
        , auto
        , backgroundColor
        , block
        , center
        , color
        , display
        , fixed
        , fontFamilies
        , fontSize
        , height
        , int
        , left
        , lineHeight
        , margin2
        , maxWidth
        , minHeight
        , minWidth
        , num
        , opacity
        , paddingTop
        , pct
        , position
        , px
        , rgb
        , rgba
        , textAlign
        , textShadow4
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


videoPlayerPaused : Style
videoPlayerPaused =
    Css.batch
        [ backgroundColor (rgba 0 0 0 0.7)
        , color (rgb 255 255 255)
        , display block
        , fontFamilies [ "Source Code Pro", "sans-serif" ]
        , fontSize (px 14)
        , height (pct 100)
        , left (px 0)
        , opacity (int 1)
        , position absolute
        , textAlign center
        , textShadow4 (px 0) (px 0) (px 8) (rgba 255 255 255 0.8)
        , top (px 0)
        , width (pct 100)
        , zIndex (int 0)
        ]


videoPlayerPausedContent : Style
videoPlayerPausedContent =
    Css.batch
        [ fontSize (px 20)
        , lineHeight (num 1.4)
        , margin2 (px 0) auto
        , maxWidth (px 600)
        , paddingTop (px 80)
        ]
