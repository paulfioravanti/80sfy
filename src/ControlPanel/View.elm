module ControlPanel.View exposing (Context, Msgs, view)

import Animation
import AudioPlayer exposing (AudioPlayer)
import ControlPanel.Model exposing (ControlPanel)
import ControlPanel.Msg as Msg exposing (Msg)
import ControlPanel.State as State
import ControlPanel.View.Controls as Controls
import ControlPanel.View.Credits as Credits
import ControlPanel.View.Styles as Styles
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
import Ports
import SoundCloud


type alias Context a =
    { a
        | audioPlayer : AudioPlayer
        , controlPanel : ControlPanel
    }


type alias Msgs msgs msg =
    { msgs
        | audioPlayerMsg : AudioPlayer.Msg -> msg
        , controlPanelMsg : Msg -> msg
        , pauseMsg : msg
        , playMsg : msg
        , portsMsg : Ports.Msg -> msg
    }


view : Msgs msgs msg -> Context a -> Html msg
view msgs ({ audioPlayer, controlPanel } as context) =
    let
        { audioPlayerMsg, controlPanelMsg } =
            msgs

        attributes =
            [ attribute "data-name" "control-panel"
            , css [ Styles.controlPanel ]
            ]

        -- NOTE: This cannot go in ControlPanel.Animation due to
        -- Animation.Model.Animation msg type not being exposed
        -- https://github.com/mdgriffith/elm-style-animation/issues/67
        animations =
            controlPanel.style
                |> Animation.render
                |> List.map fromUnstyled

        visibilityToggles =
            if controlPanel.state == State.keepVisible then
                []

            else
                [ onMouseEnter (Msg.useControlPanel controlPanelMsg)
                , onMouseLeave (Msg.leaveControlPanel controlPanelMsg)
                ]
    in
    div (attributes ++ animations ++ visibilityToggles)
        [ div
            [ css [ Styles.controlPanelContent ]
            , attribute "data-name" "panel-content"
            ]
            [ logo
            , trackInfo audioPlayer
            , Controls.view msgs context
            , volumeControl audioPlayerMsg audioPlayer
            , Credits.view
            ]
        ]



-- PRIVATE


logo : Html msg
logo =
    div [ css [ Styles.logo ], attribute "data-name" "logo" ]
        [ div [ css [ Styles.logoImageBackground ] ] []
        , img
            [ attribute "data-name" "logo-image"
            , css [ Styles.logoImage ]
            , src "assets/logo.png"
            ]
            []
        ]


trackInfo : AudioPlayer -> Html msg
trackInfo { id, soundCloudIframeUrl } =
    let
        audioPlayerId =
            AudioPlayer.rawId id

        rawSoundCloudIframeUrl =
            SoundCloud.rawIframeUrl soundCloudIframeUrl
    in
    -- NOTE: the "allow: autoplay" is needed here even though we are not
    -- automatically starting the player without user input. It is needed so
    -- that a user can also start the SoundCloud audio widget using the the Play
    -- button in the web controls, and not just on the iframe itself.
    div
        [ attribute "data-name" "track-info"
        , css [ Styles.trackInfo ]
        ]
        [ iframe
            [ css [ Styles.trackPlayer ]
            , attribute "allow" "autoplay"
            , attribute "data-name" audioPlayerId
            , Attributes.id audioPlayerId
            , src rawSoundCloudIframeUrl
            ]
            []
        ]


volumeControl : (AudioPlayer.Msg -> msg) -> AudioPlayer -> Html msg
volumeControl audioPlayerMsg { volume } =
    let
        volumeString =
            volume
                |> AudioPlayer.rawVolume
                |> String.fromInt

        adjustVolumeMsg =
            AudioPlayer.adjustVolumeMsg audioPlayerMsg
    in
    div
        [ attribute "data-name" "volume"
        , css [ Styles.volume ]
        ]
        [ div [ css [ Styles.volumeBackground ] ]
            []
        , input
            [ css [ Styles.volumeControl ]
            , type_ "range"
            , Attributes.min "0"
            , Attributes.max "100"
            , step "5"
            , value volumeString
            , onInput adjustVolumeMsg
            ]
            []
        ]
