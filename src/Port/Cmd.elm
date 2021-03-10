port module Port.Cmd exposing (cmd)

import Json.Encode as Encode
import Port.Msg as Msg exposing (Msg)
import PortMessage exposing (PortMessage)


port outbound : PortMessage -> Cmd msg


cmd : Msg -> Cmd msg
cmd msg =
    case msg of
        Msg.ExitFullscreen ->
            outbound (PortMessage.withTag "EXIT_FULL_SCREEN")

        Msg.HaltVideos ->
            outbound (PortMessage.withTag "HALT_VIDEOS")

        Msg.InitSoundCloudWidget { id, volume } ->
            let
                payload =
                    Encode.object
                        [ ( "id", Encode.string id )
                        , ( "volume", Encode.int volume )
                        ]

                portMessage =
                    PortMessage.withTaggedPayload ( "INIT_WIDGET", payload )
            in
            outbound portMessage

        Msg.Log payload ->
            outbound (PortMessage.withTaggedPayload ( "LOG", payload ))

        Msg.PauseAudio ->
            outbound (PortMessage.withTag "PAUSE_AUDIO")

        Msg.PauseVideos ->
            outbound (PortMessage.withTag "PAUSE_VIDEOS")

        Msg.PlayAudio ->
            outbound (PortMessage.withTag "PLAY_AUDIO")

        Msg.PlayVideos ->
            outbound (PortMessage.withTag "PLAY_VIDEOS")

        Msg.SetVolume volume ->
            let
                payload =
                    Encode.object [ ( "volume", Encode.int volume ) ]

                portMessage =
                    PortMessage.withTaggedPayload ( "SET_VOLUME", payload )
            in
            outbound portMessage

        Msg.SkipToTrack trackNumber ->
            let
                payload =
                    Encode.object [ ( "trackNumber", Encode.int trackNumber ) ]

                portMessage =
                    PortMessage.withTaggedPayload ( "SKIP_TO_TRACK", payload )
            in
            outbound portMessage

        Msg.ToggleFullscreen ->
            outbound (PortMessage.withTag "TOGGLE_FULL_SCREEN")
