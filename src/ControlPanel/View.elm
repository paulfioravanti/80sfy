module ControlPanel.View exposing (view)

import Animation
import ControlPanel.Model exposing (ControlPanel)
import Html.Styled as Html
    exposing
        ( Html
        , a
        , br
        , div
        , i
        , img
        , input
        , span
        , text
        , video
        )
import Html.Styled.Attributes as Attributes
    exposing
        ( attribute
        , class
        , css
        , fromUnstyled
        , href
        , src
        , step
        , target
        , type_
        , value
        )
import Html.Styled.Events exposing (onMouseEnter, onMouseLeave)
import Msg exposing (Msg(UseControlPanel))
import Styles


view : ControlPanel -> Html Msg
view controlPanel =
    let
        animations =
            controlPanel.style
                |> Animation.render
                |> List.map fromUnstyled
    in
        div
            (animations
                ++ [ css [ Styles.controlPanel ]
                   , attribute "data-name" "control-panel"
                   , onMouseEnter (UseControlPanel True)
                   , onMouseLeave (UseControlPanel False)
                   ]
            )
            [ div
                [ css [ Styles.controlPanelContent ]
                , attribute "data-name" "panel-content"
                ]
                [ logo
                , trackInfo
                , audioPlayerControls
                , volumeControl
                , credits
                ]
            ]


logo : Html msg
logo =
    div
        [ css [ Styles.logo ]
        , attribute "data-name" "logo"
        ]
        [ div [ css [ Styles.logoImageBackground ] ]
            []
        , img
            [ css [ Styles.logoImage ]
            , src "assets/logo.png"
            , attribute "data-name" "logo-image"
            ]
            []
        ]


trackInfo : Html msg
trackInfo =
    div
        [ css [ Styles.trackInfo ]
        , attribute "data-name" "track-info"
        ]
        []


audioPlayerControls : Html msg
audioPlayerControls =
    div
        [ css [ Styles.controls ]
        , attribute "data-name" "controls"
        ]
        [ div
            [ css [ Styles.controlButton ]
            , attribute "data-name" "mute-unmute"
            ]
            [ div [ css [ Styles.controlIconBackground ] ]
                []
            , i
                [ css [ Styles.controlIcon ]
                , class "fas fa-volume-up"
                ]
                []
            ]
        , div
            [ css [ Styles.controlButton ]
            , attribute "data-name" "play-pause"
            ]
            [ div [ css [ Styles.controlIconBackground ] ]
                []
            , i
                [ css [ Styles.controlIcon ]
                , class "fas fa-play"
                ]
                []
            ]
        , div
            [ css [ Styles.controlButton ]
            , attribute "data-name" "next-track"
            ]
            [ div [ css [ Styles.controlIconBackground ] ]
                []
            , i
                [ css [ Styles.controlIcon ]
                , class "fas fa-fast-forward"
                ]
                []
            ]
        , div
            [ css [ Styles.controlButton ]
            , attribute "data-name" "fullscreen"
            ]
            [ div [ css [ Styles.controlIconBackground ] ]
                []
            , i
                [ css [ Styles.controlIcon ]
                , class "fas fa-expand-arrows-alt"
                ]
                []
            ]
        ]


volumeControl : Html msg
volumeControl =
    div
        [ css [ Styles.volume ]
        , attribute "data-name" "volume"
        ]
        [ div [ css [ Styles.volumeBackground ] ]
            []
        , input
            [ css [ Styles.volumeControl ]
            , type_ "range"
            , Attributes.min "0"
            , Attributes.max "100"
            , step "5"
            , value "80"
            ]
            []
        ]


credits : Html msg
credits =
    div
        [ css [ Styles.credits ]
        , attribute "data-name" "credits"
        ]
        [ div [ css [ Styles.creditsBackground ] ]
            []
        , div
            [ css [ Styles.creditsHeader ]
            , attribute "data-name" "credit-header"
            ]
            [ text "Powered by" ]
        , div
            [ css [ Styles.creditsIcons ]
            , attribute "data-name" "credit-icons"
            ]
            [ a
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
            , a
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
            ]
        , div
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
        , div
            [ css [ Styles.creditsCopyright ]
            , attribute "data-name" "credit-copyright"
            ]
            [ text "Copyright 2017" ]
        , div
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
        , div
            [ css [ Styles.creditsPorterCopyright ]
            , attribute "data-name" "credit-copyright"
            ]
            [ text "Copyright 2018" ]
        ]
