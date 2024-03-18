module ControlPanel.View.Styled exposing
    ( controlButton
    , controlPanel
    , controlPanelContent
    , controls
    , credits
    , creditsBackground
    , creditsCopyright
    , creditsCreator
    , creditsHeader
    , creditsIconImage
    , creditsIconLink
    , creditsIcons
    , creditsLink
    , creditsPorter
    , icon
    , iconBackground
    , logo
    , logoImage
    , logoImageBackground
    , trackInfo
    , trackPlayer
    , volume
    , volumeBackground
    , volumeControl
    )

import ControlPanel.View.Colors as Colors
import Css
    exposing
        ( Style
        , absolute
        , active
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
        , borderStyle
        , borderWidth
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
        , focus
        , fontFamilies
        , fontSize
        , height
        , hidden
        , hover
        , inset
        , int
        , lastChild
        , left
        , lineHeight
        , linearGradient2
        , marginBottom
        , marginLeft
        , marginRight
        , marginTop
        , noRepeat
        , none
        , outline
        , overflow
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
import Css.Global exposing (children)
import Html.Styled
    exposing
        ( Attribute
        , Html
        , a
        , div
        , i
        , iframe
        , img
        , input
        , styled
        )


controlButton : List (Attribute msg) -> List (Html msg) -> Html msg
controlButton =
    styled div
        [ active
            [ borderStyle inset ]
        , backgroundColor Colors.background
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


controlPanel : List (Attribute msg) -> List (Html msg) -> Html msg
controlPanel =
    styled div
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


controlPanelContent : List (Attribute msg) -> List (Html msg) -> Html msg
controlPanelContent =
    styled div
        [ boxSizing borderBox
        , cursor default
        , height (pct 100)
        , padding (px 10)
        , position relative
        , top (px 0)
        , width (px 220)
        ]


controls : List (Attribute msg) -> List (Html msg) -> Html msg
controls =
    styled div
        [ after
            [ display block
            , property "clear" "both"
            , property "content" "' '"
            ]
        , children
            [ Css.Global.div
                [ lastChild
                    [ marginRight (px 0) ]
                ]
            ]
        ]


credits : List (Attribute msg) -> List (Html msg) -> Html msg
credits =
    styled div
        [ backgroundColor Colors.background
        , boxShadow4 (px 0) (px 0) (px 12) Colors.blue
        , boxSizing borderBox
        , border3 (px 3) double Colors.blue
        , color Colors.white
        , fontFamilies [ "Source Code Pro", "sans-serif" ]
        , fontSize (pct 80)
        , height (px 210)
        , padding (px 10)
        , position relative
        , textAlign center
        , textShadow4 (px 0) (px 0) (px 8) (Colors.whiteWithAlpha 0.8)
        , textTransform uppercase
        , width (px 200)
        ]


creditsBackground : List (Attribute msg) -> List (Html msg) -> Html msg
creditsBackground =
    styled div
        [ scanlines (px 210) (px 200) (px -2) ]


creditsCopyright : List (Attribute msg) -> List (Html msg) -> Html msg
creditsCopyright =
    styled div
        [ fontSize (pct 80) ]


creditsCreator : List (Attribute msg) -> List (Html msg) -> Html msg
creditsCreator =
    styled div
        [ marginBottom (px 5) ]


creditsHeader : List (Attribute msg) -> List (Html msg) -> Html msg
creditsHeader =
    styled div
        [ marginBottom (px 14) ]


creditsIcons : List (Attribute msg) -> List (Html msg) -> Html msg
creditsIcons =
    styled div
        [ marginBottom (px 14) ]


creditsIconLink : List (Attribute msg) -> List (Html msg) -> Html msg
creditsIconLink =
    styled a
        [ marginBottom (px 0)
        , marginLeft (px 10)
        , marginRight (px 10)
        , marginTop (px 0)
        ]


creditsIconImage : List (Attribute msg) -> List (Html msg) -> Html msg
creditsIconImage =
    styled img
        [ border (px 0)
        , height (px 40)
        ]


creditsLink : List (Attribute msg) -> List (Html msg) -> Html msg
creditsLink =
    styled a
        [ backgroundColor transparent
        , textDecoration none
        , color Colors.white
        ]


creditsPorter : List (Attribute msg) -> List (Html msg) -> Html msg
creditsPorter =
    styled div
        [ marginBottom (px 5)
        , marginTop (px 10)
        ]


icon : List (Attribute msg) -> List (Html msg) -> Html msg
icon =
    styled i
        [ backgroundImage
            (linearGradient2
                toBottom
                (stop2 Colors.yellow (pct 0))
                (stop2 Colors.pastelOrange (pct 50))
                [ stop2 Colors.yellow (pct 100) ]
            )
        , color Colors.white
        , fontSize (px 18)
        , hover
            [ backgroundColor Colors.white
            , backgroundImage none
            ]
        , marginLeft (px 2)
        , marginTop (px 10)
        , property "-webkit-background-clip" "text"
        , property "background-clip" "text"
        , property "-webkit-text-fill-color" "transparent"
        , property "text-fill-color" "transparent"
        , textShadow4 (px 0) (px 0) (px 10) Colors.yellow
        ]


iconBackground : List (Attribute msg) -> List (Html msg) -> Html msg
iconBackground =
    styled div
        [ scanlines (px 44) (px 44) (px -2) ]


logo : List (Attribute msg) -> List (Html msg) -> Html msg
logo =
    styled div
        [ backgroundColor transparent
        , backgroundImage (url "https://i.giphy.com/yrIRi67zxPmo.gif")
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


logoImage : List (Attribute msg) -> List (Html msg) -> Html msg
logoImage =
    styled img
        [ border (px 0)
        , height (pct 90)
        , marginTop (pct 5)
        ]


logoImageBackground : List (Attribute msg) -> List (Html msg) -> Html msg
logoImageBackground =
    styled div
        [ scanlines (px 120) (px 200) (px -2) ]


trackInfo : List (Attribute msg) -> List (Html msg) -> Html msg
trackInfo =
    styled div
        [ backgroundColor Colors.background
        , boxSizing borderBox
        , color Colors.white
        , controlPanelItemBorder
        , height (px 126)
        , marginBottom (px 8)
        , position relative
        , textAlign center
        ]


trackPlayer : List (Attribute msg) -> List (Html msg) -> Html msg
trackPlayer =
    styled iframe
        [ borderWidth (px 0)
        , height (px 120)
        , overflow hidden
        , property "scrolling" "no"
        , width (pct 100)
        ]


volume : List (Attribute msg) -> List (Html msg) -> Html msg
volume =
    styled div
        [ marginBottom (px 20)
        , marginTop (px 10)
        , position relative
        ]


volumeBackground : List (Attribute msg) -> List (Html msg) -> Html msg
volumeBackground =
    styled div
        [ scanlines (pct 85) (pct 100) (px 0) ]


volumeControl : List (Attribute msg) -> List (Html msg) -> Html msg
volumeControl =
    styled input
        [ focus
            [ outline none ]
        , marginBottom (px 0)
        , marginLeft (px -0.15)
        , marginTop (px 0)
        , marginRight (px -0.15)
        , property "-webkit-appearance" "none"
        , pseudoElement "-moz-range-track" trackStyles
        , pseudoElement "-moz-range-thumb" thumbStyles
        , pseudoElement "-webkit-slider-runnable-track" trackStyles
        , pseudoElement "-webkit-slider-thumb"
            (property "-webkit-appearance" "none" :: thumbStyles)
        , width (pct 100)
        ]



-- PRIVATE


controlPanelItemBorder : Style
controlPanelItemBorder =
    Css.batch
        [ border3 (px 3) double Colors.blue
        , boxShadow4 (px 0) (px 0) (px 12) Colors.blue
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


thumbStyles : List Style
thumbStyles =
    [ backgroundColor (Colors.yellowWithAlpha 0.96)
    , border3 (px 0) solid Colors.yellow
    , borderRadius (px 0)
    , boxShadow4 (px 0) (px 0) (px 1.8) Colors.paleYellow
    , boxShadow4 (px 1.8) (px 1.8) (px 5.9) (Colors.yellowWithAlpha 0.49)
    , cursor pointer
    , height (px 18)
    , marginTop (px 0.15)
    , width (px 18)
    ]


trackStyles : List Style
trackStyles =
    [ backgroundColor Colors.blue
    , border3 (px 0) solid Colors.black
    , borderRadius (px 0)
    , boxShadow4 (px 0) (px 0) (px 2) (Colors.whiteWithAlpha 0.12)
    , boxShadow4 (px 2) (px 2) (px 1) (Colors.whiteWithAlpha 0.12)
    , cursor pointer
    , height (px 18)
    , width (pct 100)
    ]
