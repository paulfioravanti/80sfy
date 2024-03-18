module SecretConfig.View.Styled exposing
    ( configButton
    , configInput
    , gifTags
    , secretConfig
    , secretConfigButton
    )

import Css
    exposing
        ( Style
        , auto
        , block
        , bottom
        , color
        , cursor
        , display
        , fixed
        , fontFamilies
        , fontSize
        , height
        , inherit
        , int
        , margin
        , none
        , overflow
        , pct
        , pointer
        , position
        , px
        , right
        , textAlign
        , top
        , width
        , zIndex
        )
import Html.Styled
    exposing
        ( Attribute
        , Html
        , button
        , div
        , input
        , styled
        , textarea
        )


configButton : List (Attribute msg) -> List (Html msg) -> Html msg
configButton =
    styled button
        [ cursor pointer
        , display block
        , fontFamilies [ "Source Code Pro", "sans-serif" ]
        , fontSize (px 14)
        ]


configInput : List (Attribute msg) -> List (Html msg) -> Html msg
configInput =
    styled input
        [ color inherit
        , fontFamilies [ "Source Code Pro", "sans-serif" ]
        , fontSize (px 14)
        , margin (px 0)
        , width (pct 100)
        ]


gifTags : List (Attribute msg) -> List (Html msg) -> Html msg
gifTags =
    styled textarea
        [ color inherit
        , fontFamilies [ "Source Code Pro", "sans-serif" ]
        , fontSize (px 14)
        , height (px 200)
        , margin (px 0)
        , overflow auto
        , width (pct 100)
        ]


secretConfig : Bool -> List (Attribute msg) -> List (Html msg) -> Html msg
secretConfig visible =
    let
        visibility : Style
        visibility =
            if visible then
                display block

            else
                display none
    in
    styled div
        [ visibility
        , fontFamilies [ "Source Code Pro", "sans-serif" ]
        , fontSize (px 14)
        , height (pct 100)
        , position fixed
        , right (px 0)
        , textAlign right
        , top (px 0)
        , width (px 400)
        , zIndex (int -2)
        ]


secretConfigButton : List (Attribute msg) -> List (Html msg) -> Html msg
secretConfigButton =
    styled div
        [ bottom (px 0)
        , display block
        , height (px 20)
        , position fixed
        , right (px 0)
        , width (px 20)
        , zIndex (int -1)
        ]
