module Key exposing (Key, pressed, subscriptions)

import Key.Model as Key exposing (Key)
import Key.Subscriptions as Subscriptions
import Model exposing (Model)


type alias Key =
    Key.Key


pressed : Key.ParentMsgs msgs msg -> Model -> Key -> Cmd msg
pressed parentMsgs model key =
    Key.pressed parentMsgs model key


subscriptions : Subscriptions.ParentMsgs msgs msg -> Sub msg
subscriptions parentMsgs =
    Subscriptions.subscriptions parentMsgs
