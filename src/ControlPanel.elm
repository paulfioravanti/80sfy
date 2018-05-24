module ControlPanel
    exposing
        ( ControlPanel
        , hide
        , init
        , show
        , styles
        , updateStyle
        )

import Animation exposing (px)


type alias ControlPanel =
    { style : Animation.State
    , visible : Bool
    }


type alias Styles =
    { open : List Animation.Property
    , closed : List Animation.Property
    }


init : ControlPanel
init =
    { style = Animation.style styles.closed
    , visible = False
    }


styles : Styles
styles =
    { open = [ Animation.left (px 0.0) ]
    , closed = [ Animation.left (px -220.0) ]
    }


hide : ControlPanel -> ControlPanel
hide controlPanel =
    { controlPanel
        | style =
            Animation.interrupt
                [ Animation.to styles.closed ]
                controlPanel.style
        , visible = False
    }


show : ControlPanel -> ControlPanel
show controlPanel =
    { controlPanel
        | style =
            Animation.interrupt
                [ Animation.to styles.open ]
                controlPanel.style
        , visible = True
    }


updateStyle : Animation.Msg -> ControlPanel -> ControlPanel
updateStyle msg controlPanel =
    { controlPanel | style = Animation.update msg controlPanel.style }
