module Styles
    exposing
        ( controlButton
        , controlIcon
        , controlIconBackground
        , controlPanel
        , controlPanelContent
        , controls
        , credits
        , creditsBackground
        , creditsCopyright
        , creditsCreator
        , creditsHeader
        , creditsIcons
        , creditsIconLink
        , creditsIconImage
        , creditsLink
        , logo
        , logoImage
        , logoImageBackground
        , playerGifContainer
        , trackInfo
        , videoPlayer
        , volume
        , volumeBackground
        , volumeControl
        )

import Css
    exposing
        ( Color
        , Style
        , absolute
        , after
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
        , borderRadius
        , both
        , boxShadow4
        , boxSizing
        , center
        , color
        , content
        , cursor
        , default
        , display
        , double
        , fixed
        , float
        , focus
        , fontFamilies
        , fontSize
        , height
        , hover
        , int
        , lastChild
        , left
        , lineHeight
        , linearGradient2
        , marginBottom
        , marginLeft
        , marginRight
        , marginTop
        , minHeight
        , minWidth
        , none
        , noRepeat
        , outline
        , padding
        , pct
        , pointer
        , pointerEvents
        , position
        , property
        , pseudoElement
        , px
        , relative
        , repeat
        , rgb
        , rgba
        , solid
        , stop2
        , textAlign
        , textDecoration
        , textShadow4
        , textTransform
        , toBottom
        , top
        , transparent
        , uppercase
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
        , hover
            [ backgroundColor (rgb 255 255 255)
            , backgroundImage none
            ]
        , marginLeft (px 2)
        , marginTop (px 10)
        , property "-webkit-background-clip" "text"
        , property "background-clip" "text"
        , property "-webkit-text-fill-color" "transparent"
        , property "text-fill-color" "transparent"
        , textShadow4 (px 0) (px 0) (px 10) (rgba 241 231 103 1.0)
        ]


controlIconBackground : Style
controlIconBackground =
    Css.batch
        [ scanlines (px 44) (px 44) (px -2) ]


controlPanel : Style
controlPanel =
    Css.batch
        [ display block
        , fontSize (px 14)
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
    Css.batch
        [ border3 (px 3) double miamiBlue
        , boxShadow4 (px 0) (px 0) (px 12) miamiBlue
        ]


controls : Style
controls =
    Css.batch
        [ after
            [ display block
            , property "clear" "both"
            , property "content" "' '"
            ]
        , children
            [ div
                [ lastChild
                    [ marginRight (px 0) ]
                ]
            ]
        ]


credits : Style
credits =
    Css.batch
        [ backgroundColor (rgba 0 0 0 0.2)
        , boxShadow4 (px 0) (px 0) (px 12) miamiBlue
        , boxSizing borderBox
        , border3 (px 3) double miamiBlue
        , color (rgb 255 255 255)
        , fontFamilies [ "Source Code Pro", "sans-serif" ]
        , fontSize (pct 80)
        , height (px 160)
        , padding (px 10)
        , position relative
        , textAlign center
        , textShadow4 (px 0) (px 0) (px 8) (rgba 255 255 255 0.8)
        , textTransform uppercase
        , width (px 200)
        ]


creditsBackground : Style
creditsBackground =
    Css.batch
        [ scanlines (px 160) (px 200) (px -2) ]


creditsCopyright : Style
creditsCopyright =
    Css.batch
        [ fontSize (pct 80) ]


creditsCreator : Style
creditsCreator =
    Css.batch
        [ marginBottom (px 5) ]


creditsHeader : Style
creditsHeader =
    Css.batch
        [ marginBottom (px 14) ]


creditsIcons : Style
creditsIcons =
    Css.batch
        [ marginBottom (px 14) ]


creditsIconLink : Style
creditsIconLink =
    Css.batch
        [ marginBottom (px 0)
        , marginLeft (px 10)
        , marginRight (px 10)
        , marginTop (px 0)
        ]


creditsIconImage : Style
creditsIconImage =
    Css.batch
        [ border (px 0)
        , height (px 40)
        ]


creditsLink : Style
creditsLink =
    Css.batch
        [ backgroundColor transparent
        , textDecoration none
        , color (rgb 255 255 255)
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
    scanlines (px 120) (px 200) (px -2)


miamiBlue : Color
miamiBlue =
    rgb 102 200 255


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


volume : Style
volume =
    Css.batch
        [ marginBottom (px 20)
        , marginTop (px 10)
        , position relative
        ]


volumeBackground : Style
volumeBackground =
    scanlines (pct 85) (pct 100) (px 0)


volumeControl : Style
volumeControl =
    Css.batch
        [ focus
            [ outline none ]
        , marginBottom (px 0)
        , marginLeft (px -0.15)
        , marginTop (px 0)
        , marginRight (px -0.15)
        , property "-webkit-appearance" "none"
        , pseudoElement "-webkit-slider-runnable-track"
            [ backgroundColor (rgb 102 200 255)
            , border3 (px 0) solid (rgb 0 0 0)
            , borderRadius (px 0)
            , boxShadow4 (px 0) (px 0) (px 2) (rgba 255 255 255 0.12)
            , boxShadow4 (px 2) (px 2) (px 1) (rgba 255 255 255 0.12)
            , cursor pointer
            , height (px 18)
            , width (pct 100)
            ]
        , pseudoElement "-webkit-slider-thumb"
            [ backgroundColor (rgba 241 231 103 0.96)
            , border3 (px 0) solid (rgb 241 231 103)
            , borderRadius (px 0)
            , boxShadow4 (px 0) (px 0) (px 1.8) (rgba 243 235 126 0.49)
            , boxShadow4 (px 1.8) (px 1.8) (px 5.9) (rgba 241 231 103 0.49)
            , cursor pointer
            , height (px 18)
            , marginTop (px 0.15)
            , property "-webkit-appearance" "none"
            , width (px 18)
            ]
        , width (pct 100)
        ]



---- PRIVATE ----


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
