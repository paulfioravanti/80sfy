module ControlPanel.Subscriptions exposing (subscriptions)

import Animation
import ControlPanel.Model exposing (ControlPanel)
import ControlPanel.Msg as Msg exposing (Msg)
import ControlPanel.State as State


subscriptions : (Msg -> msg) -> ControlPanel -> Sub msg
subscriptions controlPanelMsg controlPanel =
    Sub.batch
        [ State.visibilitySubscription controlPanelMsg controlPanel.state
        , Animation.subscription
            (controlPanelMsg << Msg.AnimateControlPanel)
            [ controlPanel.style ]
        ]
