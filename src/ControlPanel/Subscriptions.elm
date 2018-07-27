module ControlPanel.Subscriptions exposing (subscriptions)

import Animation
import ControlPanel.Model exposing (ControlPanel, State(Idle, InUse, Invisible))
import ControlPanel.Msg
    exposing
        ( Msg
            ( AnimateControlPanel
            , CountdownToHideControlPanel
            , ShowControlPanel
            )
        )
import Mouse
import MsgRouter exposing (MsgRouter)
import Time exposing (every, second)


subscriptions : MsgRouter msg -> ControlPanel -> Sub msg
subscriptions { controlPanelMsg } controlPanel =
    let
        visibilitySubscription =
            case controlPanel.state of
                Idle ->
                    every second
                        (controlPanelMsg << CountdownToHideControlPanel)

                InUse ->
                    Sub.none

                Invisible ->
                    Mouse.moves (\_ -> controlPanelMsg ShowControlPanel)
    in
        Sub.batch
            [ visibilitySubscription
            , Animation.subscription
                (controlPanelMsg << AnimateControlPanel)
                [ controlPanel.style ]
            ]
