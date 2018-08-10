module ControlPanel.View exposing (view)

import Animation
import AudioPlayer exposing (AudioPlayer)
import Browser exposing (Vendor)
import ControlPanel.Controls as Controls
import ControlPanel.Credits as Credits
import ControlPanel.Model exposing (ControlPanel, State(KeepVisible))
import ControlPanel.Msg exposing (Msg(LeaveControlPanel, UseControlPanel))
import ControlPanel.Styles as Styles
import Html.Styled exposing (Html, div, iframe, img, input)
import Html.Styled.Attributes as Attributes
    exposing
        ( attribute
        , css
        , fromUnstyled
        , src
        , step
        , type_
        , value
        )
import Html.Styled.Events exposing (onInput, onMouseEnter, onMouseLeave)
import MsgRouter exposing (MsgRouter)


view : MsgRouter msg -> Vendor -> AudioPlayer -> ControlPanel -> Html msg
view ({ controlPanelMsg } as msgRouter) vendor audioPlayer controlPanel =
    let
        animations =
            controlPanel.style
                |> Animation.render
                |> List.map fromUnstyled

        attributes =
            [ css [ Styles.controlPanel ]
            , attribute "data-name" "control-panel"
            ]

        visibilityToggles =
            case controlPanel.state of
                KeepVisible ->
                    []

                _ ->
                    [ onMouseEnter (controlPanelMsg UseControlPanel)
                    , onMouseLeave (controlPanelMsg LeaveControlPanel)
                    ]
    in
        div (animations ++ attributes ++ visibilityToggles)
            [ div
                [ css [ Styles.controlPanelContent ]
                , attribute "data-name" "panel-content"
                ]
                [ logo
                , trackInfo audioPlayer
                , Controls.view msgRouter vendor audioPlayer
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
trackInfo { id, soundCloudIframeUrl } =
    div
        [ css [ Styles.trackInfo ]
        , attribute "data-name" "track-info"
        ]
        [ iframe
            [ css [ Styles.trackPlayer ]
            , attribute "data-name" id
            , Attributes.id id
            , src soundCloudIframeUrl
            ]
            []
        ]


volumeControl : MsgRouter msg -> AudioPlayer -> Html msg
volumeControl { audioPlayerMsg } { volume } =
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
            , value (toString volume)
            , onInput (audioPlayerMsg << AudioPlayer.adjustVolumeMsg)
            ]
            []
        ]
