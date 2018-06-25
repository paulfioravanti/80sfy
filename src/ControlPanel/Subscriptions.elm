module ControlPanel.Subscriptions exposing (subscriptions)

import Animation
import ControlPanel.Model exposing (ControlPanel)
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
            if not controlPanel.hideWhenInactive then
                Sub.none
            else if controlPanel.visible && not controlPanel.inUse then
                every second (controlPanelMsg << CountdownToHideControlPanel)
            else
                Mouse.moves (\_ -> controlPanelMsg ShowControlPanel)
    in
        Sub.batch
            [ visibilitySubscription
            , Animation.subscription
                (controlPanelMsg << AnimateControlPanel)
                [ controlPanel.style ]
            ]
