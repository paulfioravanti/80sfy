module Key exposing (Key, pressed, subscriptions)

import Key.Model as Key exposing (Key)
import Key.Subscriptions as Subscriptions
import Model exposing (Model)


type alias Key =
    Key.Key


pressed : Key.ParentMsgs msgs msg -> Model -> Key -> Cmd msg
pressed msgs model key =
    Key.pressed msgs model key


subscriptions : (Key -> msg) -> Sub msg
subscriptions keyMsg =
    Subscriptions.subscriptions keyMsg
