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


subscriptions : MsgRouter msg -> Bool -> ControlPanel -> Sub msg
subscriptions { controlPanelMsg } overrideInactivityPause controlPanel =
    let
        visibilitySubscription =
            if overrideInactivityPause then
                Sub.none
            else if controlPanel.visible && not controlPanel.inUse then
                every second (controlPanelMsg << CountdownToHideControlPanel)
            else
                Mouse.moves (\_ -> (controlPanelMsg ShowControlPanel))
    in
        Sub.batch
            [ visibilitySubscription
            , Animation.subscription
                (controlPanelMsg << AnimateControlPanel)
                [ controlPanel.style ]
            ]
