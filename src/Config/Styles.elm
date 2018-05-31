module Config.Styles
    exposing
        ( playlist
        , searchTags
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
        , display
        , fixed
        , fontFamilies
        , fontSize
        , height
        , inherit
        , int
        , lineHeight
        , margin
        , none
        , normal
        , overflow
        , pct
        , position
        , px
        , right
        , textAlign
        , top
        , width
        , zIndex
        )


playlist : Style
playlist =
    Css.batch
        [ color inherit
        , fontFamilies [ "Source Code Pro", "sans-serif" ]
        , fontSize (px 14)
        , margin (px 0)
        , width (pct 100)
        ]


searchTags : Style
searchTags =
    Css.batch
        [ color inherit
        , fontFamilies [ "Source Code Pro", "sans-serif" ]
        , fontSize (px 14)
        , height (px 200)
        , margin (px 0)
        , overflow auto
        , width (pct 100)
        ]


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
