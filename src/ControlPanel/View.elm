module ControlPanel.View exposing (view)

import Animation
import ControlPanel.Credits as Credits
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

        attributes =
            [ css [ Styles.controlPanel ]
            , attribute "data-name" "control-panel"
            , onMouseEnter (UseControlPanel True)
            , onMouseLeave (UseControlPanel False)
            ]
    in
        div (animations ++ attributes)
            [ div
                [ css [ Styles.controlPanelContent ]
                , attribute "data-name" "panel-content"
                ]
                [ logo
                , trackInfo
                , audioPlayerControls
                , volumeControl
                , Credits.view
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
