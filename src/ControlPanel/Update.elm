module ControlPanel.Update exposing (update)

import Animation
import ControlPanel.Animations as Animations
import ControlPanel.Model exposing (ControlPanel)
import ControlPanel.Msg as Msg exposing (Msg)
import ControlPanel.State as State
import Task


update : Msg -> ControlPanel -> ( ControlPanel, Cmd Msg )
update msg controlPanel =
    case msg of
        Msg.AnimateControlPanel animateMsg ->
            ( { controlPanel
                | style =
                    controlPanel.style
                        |> Animation.update animateMsg
              }
            , Cmd.none
            )

        -- unused variable is `time`
        Msg.CountdownToHideControlPanel secondsVisible _ ->
            let
                timeoutSeconds =
                    2
            in
            if secondsVisible > timeoutSeconds then
                let
                    hideControlPanel =
                        Msg.HideControlPanel
                            |> Task.succeed
                            |> Task.perform identity
                in
                ( controlPanel, hideControlPanel )

            else
                ( { controlPanel | state = State.setIdle (secondsVisible + 1) }
                , Cmd.none
                )

        Msg.HideControlPanel ->
            let
                animateToHidden =
                    controlPanel.style
                        |> Animation.interrupt
                            [ Animation.to Animations.hidden ]
            in
            ( { controlPanel
                | style = animateToHidden
                , state = State.invisible
              }
            , Cmd.none
            )

        Msg.LeaveControlPanel ->
            ( { controlPanel | state = State.setIdle 0 }, Cmd.none )

        Msg.ShowControlPanel ->
            let
                animateToVisible =
                    controlPanel.style
                        |> Animation.interrupt
                            [ Animation.to Animations.visible ]
            in
            ( { controlPanel
                | style = animateToVisible
                , state = State.setIdle 0
              }
            , Cmd.none
            )

        Msg.ToggleHideWhenInactive ->
            let
                state =
                    State.toggleHideWhenInactive controlPanel.state
            in
            ( { controlPanel | state = state }, Cmd.none )

        Msg.UseControlPanel ->
            ( { controlPanel | state = State.inUse }, Cmd.none )
