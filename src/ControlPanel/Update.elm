module ControlPanel.Update exposing (update)

import Animation
import ControlPanel.Animations as Animations
import ControlPanel.Model exposing (ControlPanel, State(Idle, InUse, Invisible))
import ControlPanel.Msg
    exposing
        ( Msg
            ( AnimateControlPanel
            , CountdownToHideControlPanel
            , HideControlPanel
            , LeaveControlPanel
            , ShowControlPanel
            , ToggleHideWhenInactive
            , UseControlPanel
            )
        )
import MsgRouter exposing (MsgRouter)
import Task


update : MsgRouter msg -> Msg -> ControlPanel -> ( ControlPanel, Cmd msg )
update { controlPanelMsg } msg controlPanel =
    case msg of
        AnimateControlPanel animateMsg ->
            ( { controlPanel
                | style =
                    controlPanel.style
                        |> Animation.update animateMsg
              }
            , Cmd.none
            )

        -- unused variable is `time`
        CountdownToHideControlPanel _ ->
            let
                timeoutSeconds =
                    2
            in
                if controlPanel.secondsOpen > timeoutSeconds then
                    ( { controlPanel | secondsOpen = 0 }
                    , Task.succeed ()
                        |> Task.perform (controlPanelMsg << HideControlPanel)
                    )
                else
                    ( { controlPanel
                        | secondsOpen = controlPanel.secondsOpen + 1
                      }
                    , Cmd.none
                    )

        HideControlPanel () ->
            let
                animateToHidden =
                    controlPanel.style
                        |> Animation.interrupt
                            [ Animation.to Animations.hidden ]
            in
                ( { controlPanel | style = animateToHidden, state = Invisible }
                , Cmd.none
                )

        LeaveControlPanel ->
            ( { controlPanel | state = Idle }, Cmd.none )

        ShowControlPanel ->
            let
                animateToVisible =
                    controlPanel.style
                        |> Animation.interrupt
                            [ Animation.to Animations.visible ]
            in
                ( { controlPanel | style = animateToVisible, state = Idle }
                , Cmd.none
                )

        ToggleHideWhenInactive ->
            let
                -- "Toggle" secondsOpen between -Infinity and 0.
                -- When it's -Infinity, the
                -- (controlPanel.secondsOpen > timeoutSeconds) condition
                -- from the CountdownToHideControlPanel msg will never
                -- be satisfied, and hence the controlPanel will always stay
                -- visible.
                secondsOpen =
                    if isInfinite controlPanel.secondsOpen then
                        0
                    else
                        -1 / 0
            in
                ( { controlPanel | secondsOpen = secondsOpen }
                , Cmd.none
                )

        UseControlPanel ->
            ( { controlPanel | state = InUse }, Cmd.none )
