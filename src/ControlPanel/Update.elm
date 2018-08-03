module ControlPanel.Update exposing (update)

import Animation
import ControlPanel.Animations as Animations
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
        CountdownToHideControlPanel secondsVisible _ ->
            let
                timeoutSeconds =
                    2
            in
                if secondsVisible > timeoutSeconds then
                    let
                        hideControlPanel =
                            controlPanelMsg HideControlPanel
                                |> Task.succeed
                                |> Task.perform identity
                    in
                        ( controlPanel, hideControlPanel )
                else
                    ( { controlPanel | state = Idle (secondsVisible + 1) }
                    , Cmd.none
                    )

        HideControlPanel ->
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
            ( { controlPanel | state = Idle 0 }, Cmd.none )

        ShowControlPanel ->
            let
                animateToVisible =
                    controlPanel.style
                        |> Animation.interrupt
                            [ Animation.to Animations.visible ]
            in
                ( { controlPanel | style = animateToVisible, state = Idle 0 }
                , Cmd.none
                )

        ToggleHideWhenInactive ->
            let
                state =
                    if controlPanel.state == KeepVisible then
                        Idle 0
                    else
                        KeepVisible
            in
                ( { controlPanel | state = state }
                , Cmd.none
                )

        UseControlPanel ->
            ( { controlPanel | state = InUse }, Cmd.none )
