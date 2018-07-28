module ControlPanel.Subscriptions exposing (subscriptions)

import Animation
import ControlPanel.Model
    exposing
        ( ControlPanel
        , State
            ( Idle
            , Invisible
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
    Sub.batch
        [ visibilitySubscription controlPanelMsg controlPanel.state
        , Animation.subscription
            (controlPanelMsg << AnimateControlPanel)
            [ controlPanel.style ]
        ]


visibilitySubscription : (Msg -> msg) -> State -> Sub msg
visibilitySubscription controlPanelMsg state =
    case state of
        Idle secondsVisible ->
            every second
                (controlPanelMsg
                    << CountdownToHideControlPanel secondsVisible
                )

        Invisible ->
            Mouse.moves (\_ -> controlPanelMsg ShowControlPanel)

        _ ->
            Sub.none
