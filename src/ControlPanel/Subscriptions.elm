module ControlPanel.Subscriptions exposing (ParentMsgs, subscriptions)

import Browser.Events as Events
import ControlPanel.Animation as Animation
import ControlPanel.Model exposing (ControlPanel)
import ControlPanel.Msg as Msg exposing (Msg)
import ControlPanel.State as State exposing (State)
import Json.Decode as Decode
import Time


type alias ParentMsgs msgs msg =
    { msgs
        | controlPanelMsg : Msg -> msg
    }


subscriptions : ParentMsgs msgs msg -> ControlPanel -> Sub msg
subscriptions { controlPanelMsg } controlPanel =
    let
        animateControlPanelSubscription : Sub msg
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
            secondsVisible : Int
            secondsVisible =
                State.idleSeconds state
        in
        -- milliseconds
        Time.every 1000
            (Msg.countdownToHideControlPanel controlPanelMsg secondsVisible)

    else if state == State.invisible then
        Events.onMouseMove
            (Decode.succeed (controlPanelMsg Msg.ShowControlPanel))

    else
        Sub.none
