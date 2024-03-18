module ControlPanel.View exposing (Context, ParentMsgs, view)

import AudioPlayer exposing (AudioPlayer)
import ControlPanel.Animation as Animation
import ControlPanel.Model exposing (ControlPanel)
import ControlPanel.Msg as Msg exposing (Msg)
import ControlPanel.State as State
import ControlPanel.View.Controls as Controls
import ControlPanel.View.Credits as Credits
import ControlPanel.View.Styled as Styled
import Html.Styled as Html exposing (Html)
import Html.Styled.Attributes as Attributes
    exposing
        ( attribute
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


type alias ParentMsgs msgs msg =
    { msgs
        | audioPlayerMsg : AudioPlayer.Msg -> msg
        , controlPanelMsg : Msg -> msg
        , pauseMsg : msg
        , portsMsg : Ports.Msg -> msg
    }


view : ParentMsgs msgs msg -> Context a -> Html msg
view parentMsgs ({ audioPlayer, controlPanel } as context) =
    let
        { audioPlayerMsg, controlPanelMsg } =
            parentMsgs

        attributes : List (Html.Attribute msg)
        attributes =
            [ attribute "data-name" "control-panel" ]

        animations : List (Html.Attribute msg)
        animations =
            Animation.animations controlPanel.style

        visibilityToggles : List (Html.Attribute msg)
        visibilityToggles =
            if controlPanel.state == State.keepVisible then
                []

            else
                [ onMouseEnter (controlPanelMsg Msg.UseControlPanel)
                , onMouseLeave (controlPanelMsg Msg.LeaveControlPanel)
                ]
    in
    Styled.controlPanel (attributes ++ animations ++ visibilityToggles)
        [ Styled.controlPanelContent
            [ attribute "data-name" "panel-content" ]
            [ logo
            , trackInfo audioPlayer
            , Controls.view parentMsgs context
            , volumeControl audioPlayerMsg audioPlayer
            , Credits.view
            ]
        ]



-- PRIVATE


logo : Html msg
logo =
    Styled.logo [ attribute "data-name" "logo" ]
        [ Styled.logoImageBackground [] []
        , Styled.logoImage
            [ attribute "data-name" "logo-image"
            , src "assets/logo.png"
            ]
            []
        ]


trackInfo : AudioPlayer -> Html msg
trackInfo { id, soundCloudIframeUrl } =
    let
        audioPlayerId : String
        audioPlayerId =
            AudioPlayer.rawId id

        rawSoundCloudIframeUrl : String
        rawSoundCloudIframeUrl =
            SoundCloud.rawIframeUrl soundCloudIframeUrl
    in
    -- NOTE: the "allow: autoplay" is needed here even though we are not
    -- automatically starting the player without user input. It is needed so
    -- that a user can also start the SoundCloud audio widget using the the Play
    -- button in the web controls, and not just on the iframe itself.
    Styled.trackInfo
        [ attribute "data-name" "track-info" ]
        [ Styled.trackPlayer
            [ attribute "allow" "autoplay"
            , attribute "data-name" audioPlayerId
            , Attributes.id audioPlayerId
            , src rawSoundCloudIframeUrl
            ]
            []
        ]


volumeControl : (AudioPlayer.Msg -> msg) -> AudioPlayer -> Html msg
volumeControl audioPlayerMsg { volume } =
    let
        volumeString : String
        volumeString =
            volume
                |> AudioPlayer.rawVolume
                |> String.fromInt

        adjustVolumeMsg : String -> msg
        adjustVolumeMsg =
            AudioPlayer.adjustVolumeMsg audioPlayerMsg
    in
    Styled.volume
        [ attribute "data-name" "volume" ]
        [ Styled.volumeBackground [] []
        , Styled.volumeControl
            [ type_ "range"
            , Attributes.min "0"
            , Attributes.max "100"
            , step "5"
            , value volumeString
            , onInput adjustVolumeMsg
            ]
            []
        ]
