module ControlPanel.Subscriptions exposing (subscriptions)

import Animation
import Browser.Events as Events
import ControlPanel.Model as Model exposing (ControlPanel)
import ControlPanel.Msg as Msg exposing (Msg)
import Json.Decode as Decode
import MsgRouter exposing (MsgRouter)
import Time


subscriptions : MsgRouter msg -> ControlPanel -> Sub msg
subscriptions { controlPanelMsg } controlPanel =
    Sub.batch
        [ visibilitySubscription controlPanelMsg controlPanel.state
        , Animation.subscription
            (controlPanelMsg << Msg.AnimateControlPanel)
            [ controlPanel.style ]
        ]


visibilitySubscription : (Msg -> msg) -> Model.State -> Sub msg
visibilitySubscription controlPanelMsg state =
    case state of
        Model.Idle secondsVisible ->
            Time.every 1000
                (controlPanelMsg
                    << Msg.CountdownToHideControlPanel secondsVisible
                )

        Model.Invisible ->
            Events.onMouseMove
                (Decode.succeed (controlPanelMsg Msg.ShowControlPanel))

        _ ->
            Sub.none
