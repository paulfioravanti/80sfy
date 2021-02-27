module ControlPanel.Task exposing (performHideControlPanel)

import ControlPanel.Msg as Msg exposing (Msg)
import Task


performHideControlPanel : (Msg -> msg) -> Cmd msg
performHideControlPanel controlPanelMsg =
    Msg.hideControlPanel controlPanelMsg
        |> Task.succeed
        |> Task.perform identity
