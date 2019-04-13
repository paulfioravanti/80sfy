module Key.Subscriptions exposing (subscriptions)

import Browser.Events as Events
import Json.Decode as Decode
import Key.Decoder as Decoder
import Key.Model exposing (Key)


subscriptions : (Key -> msg) -> Sub msg
subscriptions keyMsg =
    Events.onKeyDown (Decode.map keyMsg Decoder.decoder)
