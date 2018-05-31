module ControlPanel.View exposing (view)

import Animation
import AudioPlayer exposing (AudioPlayer)
import ControlPanel.Controls as Controls
import ControlPanel.Credits as Credits
import ControlPanel.Model exposing (ControlPanel)
import ControlPanel.Styles as Styles
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
import Html.Styled.Events exposing (onInput, onMouseEnter, onMouseLeave)
import Msg exposing (Msg(AdjustVolume, UseControlPanel))


view : AudioPlayer -> ControlPanel -> Html Msg
view audioPlayer controlPanel =
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
                , Controls.view audioPlayer
                , volumeControl audioPlayer
                , Credits.view
                ]
            ]


logo : Html msg
logo =
    div [ css [ Styles.logo ], attribute "data-name" "logo" ]
        [ div [ css [ Styles.logoImageBackground ] ] []
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


volumeControl : AudioPlayer -> Html Msg
volumeControl { muted, volume } =
    let
        volumeDisplayValue =
            if muted then
                "0"
            else
                volume
    in
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
                , value volumeDisplayValue
                , onInput AdjustVolume
                ]
                []
            ]
