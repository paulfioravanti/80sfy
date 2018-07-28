module ControlPanel.Subscriptions exposing (subscriptions)

import Animation
import ControlPanel.Model
    exposing
        ( ControlPanel
        , State
            ( Idle
            , InUse
            , Invisible
            , KeepVisible
            )
        )
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
                Idle secondsVisible ->
                    every second
                        (controlPanelMsg
                            << (CountdownToHideControlPanel secondsVisible)
                        )

                InUse ->
                    Sub.none

                Invisible ->
                    Mouse.moves (\_ -> controlPanelMsg ShowControlPanel)

                KeepVisible ->
                    Sub.none
    in
        Sub.batch
            [ visibilitySubscription
            , Animation.subscription
                (controlPanelMsg << AnimateControlPanel)
                [ controlPanel.style ]
            ]
