module Key.Subscriptions exposing (ParentMsgs, subscriptions)

import Browser.Events as Events
import Json.Decode as Decode
import Key.Decoder as Decoder
import Key.Model exposing (Key)


type alias ParentMsgs msgs msg =
    { msgs
        | keyPressedMsg : Key -> msg
    }


subscriptions : ParentMsgs msgs msg -> Sub msg
subscriptions { keyPressedMsg } =
    Events.onKeyDown (Decode.map keyPressedMsg Decoder.decoder)
