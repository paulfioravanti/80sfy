module ControlPanel.Credits exposing (view)

import ControlPanel.Styles as Styles
import Html.Styled as Html exposing (Html, a, br, div, img, span, text)
import Html.Styled.Attributes exposing (attribute, css, href, src, target)


view : Html msg
view =
    div [ css [ Styles.credits ], attribute "data-name" "credits" ]
        [ div [ css [ Styles.creditsBackground ] ]
            []
        , header
        , icons
        , creator
        , creatorCopyright
        , porter
        , porterCopyright
        ]


header : Html msg
header =
    div
        [ css [ Styles.creditsHeader ]
        , attribute "data-name" "credit-header"
        ]
        [ text "Powered by" ]


icons : Html msg
icons =
    div
        [ css [ Styles.creditsIcons ]
        , attribute "data-name" "credit-icons"
        ]
        [ giphyIconLink
        , soundCloudIconLink
        ]


creator : Html msg
creator =
    div
        [ css [ Styles.creditsCreator ]
        , attribute "data-name" "credit-creator"
        ]
        [ span []
            [ text "Created by" ]
        , br [] []
        , a
            [ css [ Styles.creditsLink ]
            , href "http://www.digitalbloc.com"
            , target "_blank"
            ]
            [ text "Art Sangurai" ]
        ]


creatorCopyright : Html msg
creatorCopyright =
    div
        [ css [ Styles.creditsCopyright ]
        , attribute "data-name" "credit-creator-copyright"
        ]
        [ text "Copyright 2017" ]


giphyIconLink : Html msg
giphyIconLink =
    a
        [ css [ Styles.creditsIconLink ]
        , href "https://www.giphy.com"
        , target "_blank"
        ]
        [ img
            [ css [ Styles.creditsIconImage ]
            , src "assets/giphy.png"
            ]
            []
        ]


porter : Html msg
porter =
    div
        [ css [ Styles.creditsPorter ]
        , attribute "data-name" "credit-porter"
        ]
        [ span []
            [ text "Elm port by" ]
        , br [] []
        , a
            [ css [ Styles.creditsLink ]
            , href "http://www.paulfioravanti.com"
            , target "_blank"
            ]
            [ text "Paul Fioravanti" ]
        ]


porterCopyright : Html msg
porterCopyright =
    div
        [ css [ Styles.creditsPorterCopyright ]
        , attribute "data-name" "credit-porter-copyright"
        ]
        [ text "Copyright 2018" ]


soundCloudIconLink : Html msg
soundCloudIconLink =
    a
        [ css [ Styles.creditsIconLink ]
        , href "https://www.soundcloud.com"
        , target "_blank"
        ]
        [ img
            [ css [ Styles.creditsIconImage ]
            , src "assets/soundcloud.png"
            ]
            []
        ]
