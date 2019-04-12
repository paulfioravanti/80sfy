module ControlPanel.Subscriptions exposing (subscriptions)

import Animation
import Browser.Events as Events
import ControlPanel.Model exposing (ControlPanel)
import ControlPanel.Msg as Msg exposing (Msg)
import ControlPanel.State as State exposing (State)
import Json.Decode as Decode
import Time


subscriptions : (Msg -> msg) -> ControlPanel -> Sub msg
subscriptions controlPanelMsg controlPanel =
    Sub.batch
        [ visibilitySubscription controlPanelMsg controlPanel.state
        , Animation.subscription
            (controlPanelMsg << Msg.AnimateControlPanel)
            [ controlPanel.style ]
        ]



-- PRIVATE


visibilitySubscription : (Msg -> msg) -> State -> Sub msg
visibilitySubscription controlPanelMsg state =
    case state of
        State.Idle secondsVisible ->
            Time.every 1000
                (controlPanelMsg
                    << Msg.CountdownToHideControlPanel secondsVisible
                )

        State.Invisible ->
            Events.onMouseMove
                (Decode.succeed (controlPanelMsg Msg.ShowControlPanel))

        _ ->
            Sub.none
