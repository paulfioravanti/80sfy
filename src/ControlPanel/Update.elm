module ControlPanel.Update exposing (update)

import Animation
import ControlPanel.Model exposing (ControlPanel)
import ControlPanel.Msg
    exposing
        ( Msg
            ( AnimateControlPanel
            )
        )
import MsgConfig exposing (MsgConfig)


update : MsgConfig msg -> Msg -> ControlPanel -> ( ControlPanel, Cmd msg )
update { controlPanelMsg } msg controlPanel =
    case msg of
        AnimateControlPanel msg ->
            ( { controlPanel
                | style =
                    controlPanel.style
                        |> Animation.update msg
              }
            , Cmd.none
            )
