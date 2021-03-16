module ControlPanel.Subscriptions exposing (subscriptions)

import Browser.Events
import ControlPanel.Animation as Animation
import ControlPanel.Model exposing (ControlPanel)
import ControlPanel.Msg as Msg exposing (Msg)
import ControlPanel.State as State exposing (State)
import Json.Decode as Decode
import Time


subscriptions : (Msg -> msg) -> ControlPanel -> Sub msg
subscriptions controlPanelMsg controlPanel =
    let
        animateControlPanelSubscription =
            Animation.subscription controlPanelMsg controlPanel.style
    in
    Sub.batch
        [ visibilitySubscription controlPanelMsg controlPanel.state
        , animateControlPanelSubscription
        ]



-- PRIVATE


visibilitySubscription : (Msg -> msg) -> State -> Sub msg
visibilitySubscription controlPanelMsg state =
    if State.isIdle state then
        let
            secondsVisible =
                State.idleSeconds state
        in
        -- milliseconds
        Time.every 1000
            (Msg.countdownToHideControlPanel controlPanelMsg secondsVisible)

    else if state == State.invisible then
        Browser.Events.onMouseMove
            (Decode.succeed (controlPanelMsg Msg.ShowControlPanel))

    else
        Sub.none
