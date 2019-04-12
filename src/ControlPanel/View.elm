module ControlPanel.View exposing (view)

import Animation
import AudioPlayer exposing (AudioPlayer)
import BrowserVendor exposing (BrowserVendor)
import ControlPanel.Controls as Controls
import ControlPanel.Credits as Credits
import ControlPanel.Model exposing (ControlPanel)
import ControlPanel.Msg as Msg exposing (Msg)
import ControlPanel.State as State
import ControlPanel.Styles as Styles
import FullScreen
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


view :
    (AudioPlayer.Msg -> msg)
    -> (Msg -> msg)
    -> (FullScreen.Msg -> msg)
    -> msg
    -> msg
    -> BrowserVendor
    -> AudioPlayer
    -> ControlPanel
    -> Html msg
view audioPlayerMsg controlPanelMsg fullScreenMsg pauseMsg playMsg browserVendor audioPlayer controlPanel =
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
                State.KeepVisible ->
                    []

                _ ->
                    [ onMouseEnter (controlPanelMsg Msg.UseControlPanel)
                    , onMouseLeave (controlPanelMsg Msg.LeaveControlPanel)
                    ]
    in
    div (animations ++ attributes ++ visibilityToggles)
        [ div
            [ css [ Styles.controlPanelContent ]
            , attribute "data-name" "panel-content"
            ]
            [ logo
            , trackInfo audioPlayer
            , Controls.view
                audioPlayerMsg
                fullScreenMsg
                pauseMsg
                playMsg
                browserVendor
                audioPlayer
            , volumeControl audioPlayerMsg audioPlayer
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


volumeControl : (AudioPlayer.Msg -> msg) -> AudioPlayer -> Html msg
volumeControl audioPlayerMsg { volume } =
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
            , value (String.fromInt volume)
            , onInput (audioPlayerMsg << AudioPlayer.adjustVolumeMsg)
            ]
            []
        ]
