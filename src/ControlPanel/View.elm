module ControlPanel.View exposing (Context, Msgs, view)

import Animation
import AudioPlayer exposing (AudioPlayer)
import BrowserVendor exposing (BrowserVendor)
import ControlPanel.Controls as Controls
import ControlPanel.Credits as Credits
import ControlPanel.Model exposing (ControlPanel)
import ControlPanel.Msg as Msg exposing (Msg)
import ControlPanel.State as State
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


type alias Context a =
    { a
        | browserVendor : BrowserVendor
        , audioPlayer : AudioPlayer
        , controlPanel : ControlPanel
    }


type alias Msgs msgs msg =
    { msgs
        | audioPlayerMsg : AudioPlayer.Msg -> msg
        , controlPanelMsg : Msg -> msg
        , browserVendorMsg : BrowserVendor.Msg -> msg
        , pauseMsg : msg
        , playMsg : msg
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

        animations =
            controlPanel.style
                |> Animation.render
                |> List.map fromUnstyled

        visibilityToggles =
            if controlPanel.state == State.keepVisible then
                []

            else
                [ onMouseEnter (controlPanelMsg Msg.UseControlPanel)
                , onMouseLeave (controlPanelMsg Msg.LeaveControlPanel)
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
    div
        [ attribute "data-name" "track-info"
        , css [ Styles.trackInfo ]
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
            , value (String.fromInt volume)
            , onInput (AudioPlayer.adjustVolumeMsg audioPlayerMsg)
            ]
            []
        ]
