module ControlPanel.View.Credits exposing (view)

import ControlPanel.View.Styled as Styled
import Html.Styled exposing (Html, br, text)
import Html.Styled.Attributes exposing (attribute, href, src, target)


view : Html msg
view =
    Styled.credits [ attribute "data-name" "credits" ]
        [ Styled.creditsBackground [] []
        , header
        , icons
        , creator
        , creatorCopyright
        , porter
        , porterCopyright
        ]


header : Html msg
header =
    Styled.creditsHeader
        [ attribute "data-name" "credit-header" ]
        [ text "Powered by" ]


icons : Html msg
icons =
    Styled.creditsIcons
        [ attribute "data-name" "credit-icons" ]
        [ giphyIconLink
        , soundCloudIconLink
        ]


creator : Html msg
creator =
    Styled.creditsCreator
        [ attribute "data-name" "credit-creator" ]
        [ Styled.creditsLink
            [ href "https://80sfy.com"
            , target "_blank"
            ]
            [ text "Created by" ]
        , br [] []
        , Styled.creditsLink
            [ href "http://www.digitalbloc.com"
            , target "_blank"
            ]
            [ text "Art Sangurai" ]
        ]


creatorCopyright : Html msg
creatorCopyright =
    Styled.creditsCopyright
        [ attribute "data-name" "credit-creator-copyright" ]
        [ text "Copyright 2017" ]


giphyIconLink : Html msg
giphyIconLink =
    Styled.creditsIconLink
        [ href "https://www.giphy.com"
        , target "_blank"
        ]
        [ Styled.creditsIconImage
            [ src "assets/giphy.png" ]
            []
        ]


porter : Html msg
porter =
    Styled.creditsPorter
        [ attribute "data-name" "credit-porter" ]
        [ Styled.creditsLink
            [ href "https://github.com/paulfioravanti/80sfy"
            , target "_blank"
            ]
            [ text "Elm port by" ]
        , br [] []
        , Styled.creditsLink
            [ href "https://www.paulfioravanti.com"
            , target "_blank"
            ]
            [ text "Paul Fioravanti" ]
        ]


porterCopyright : Html msg
porterCopyright =
    Styled.creditsCopyright
        [ attribute "data-name" "credit-porter-copyright" ]
        [ text "Copyright 2018-2021" ]


soundCloudIconLink : Html msg
soundCloudIconLink =
    Styled.creditsIconLink
        [ href "https://www.soundcloud.com"
        , target "_blank"
        ]
        [ Styled.creditsIconImage
            [ src "assets/soundcloud.png" ]
            []
        ]
