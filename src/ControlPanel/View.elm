module ControlPanel.View exposing (view)

import Animation
import AudioPlayer exposing (AudioPlayer)
import ControlPanel.Controls as Controls
import ControlPanel.Credits as Credits
import ControlPanel.Model exposing (ControlPanel)
import ControlPanel.Msg exposing (Msg(UseControlPanel))
import ControlPanel.Styles as Styles
import Html.Styled
    exposing
        ( Html
        , div
        , iframe
        , img
        , input
        )
import Html.Styled.Attributes as Attributes
    exposing
        ( attribute
        , css
        , fromUnstyled
        , id
        , src
        , step
        , type_
        , value
        )
import Html.Styled.Events exposing (onInput, onMouseEnter, onMouseLeave)
import MsgRouter exposing (MsgRouter)


view : MsgRouter msg -> AudioPlayer -> ControlPanel -> Html msg
view ({ controlPanelMsg } as msgRouter) audioPlayer controlPanel =
    let
        animations =
            controlPanel.style
                |> Animation.render
                |> List.map fromUnstyled

        attributes =
            [ css [ Styles.controlPanel ]
            , attribute "data-name" "control-panel"
            , onMouseEnter (controlPanelMsg (UseControlPanel True))
            , onMouseLeave (controlPanelMsg (UseControlPanel False))
            ]
    in
        div (animations ++ attributes)
            [ div
                [ css [ Styles.controlPanelContent ]
                , attribute "data-name" "panel-content"
                ]
                [ logo
                , trackInfo audioPlayer
                , Controls.view msgRouter audioPlayer
                , volumeControl msgRouter audioPlayer
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


trackInfo : AudioPlayer -> Html msg
trackInfo { soundCloudIframeUrl } =
    div
        [ css [ Styles.trackInfo ]
        , attribute "data-name" "track-info"
        ]
        [ iframe
            [ css [ Styles.trackPlayer ]
            , attribute "data-name" "track-player"
            , id "track-player"
            , src soundCloudIframeUrl
            ]
            []
        ]


volumeControl : MsgRouter msg -> AudioPlayer -> Html msg
volumeControl { audioPlayerMsg } { muted, volume } =
    let
        volumeDisplayValue =
            if muted then
                "0"
            else
                toString volume
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
                , onInput (audioPlayerMsg << AudioPlayer.adjustVolumeMsg)
                ]
                []
            ]
