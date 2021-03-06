module SoundCloud.Ports exposing (initSoundCloudWidget)

import Json.Encode as Encode
import PortMessage
import Ports


initSoundCloudWidget : ( String, Int ) -> Cmd msg
initSoundCloudWidget ( id, volume ) =
    let
        payload =
            Encode.object
                [ ( "id", Encode.string id )
                , ( "volume", Encode.int volume )
                ]

        portMessage =
            PortMessage.withTaggedPayload ( "INIT_WIDGET", payload )
    in
    Ports.out portMessage
