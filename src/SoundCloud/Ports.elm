port module SoundCloud.Ports exposing (initSoundCloudWidget)

import Json.Encode as Encode
import PortMessage exposing (PortMessage)


port toSoundCloudWidget : PortMessage -> Cmd msg


initSoundCloudWidget : ( String, Int ) -> Cmd msg
initSoundCloudWidget ( id, volume ) =
    let
        payload =
            Encode.object
                [ ( "id", Encode.string id )
                , ( "volume", Encode.int volume )
                ]
    in
    toSoundCloudWidget (PortMessage.withTaggedPayload ( "INIT", payload ))
