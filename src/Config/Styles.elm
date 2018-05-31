module Config.Styles exposing (secretConfig, secretConfigButton)

import Css
    exposing
        ( Style
        , block
        , bottom
        , display
        , fixed
        , fontFamilies
        , fontSize
        , height
        , int
        , none
        , pct
        , position
        , px
        , right
        , textAlign
        , top
        , width
        , zIndex
        )


secretConfigButton : Style
secretConfigButton =
    Css.batch
        [ bottom (px 0)
        , display block
        , height (px 20)
        , position fixed
        , right (px 0)
        , width (px 20)
        , zIndex (int 5100)
        ]


secretConfig : Bool -> Style
secretConfig visible =
    let
        visibility =
            if visible then
                display block
            else
                display none
    in
        Css.batch
            [ visibility
            , fontFamilies [ "Source Code Pro", "sans-serif" ]
            , fontSize (px 14)
            , height (pct 100)
            , position fixed
            , right (px 0)
            , textAlign right
            , top (px 0)
            , width (px 400)
            , zIndex (int 5000)
            ]
