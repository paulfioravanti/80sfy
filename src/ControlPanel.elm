module ControlPanel
    exposing
        ( ControlPanel
        , Status(..)
        , hide
        , init
        , show
        , styles
        , updateStyle
        )

import Animation exposing (px)


type Status
    = Open
    | Closed


type alias ControlPanel =
    { style : Animation.State
    , status : Status
    }


type alias Styles =
    { open : List Animation.Property
    , closed : List Animation.Property
    }


init : ControlPanel
init =
    { style = Animation.style styles.closed
    , status = Closed
    }


styles : Styles
styles =
    { open = [ Animation.left (px 0.0) ]
    , closed = [ Animation.left (px -220.0) ]
    }


hide : ControlPanel -> ControlPanel
hide controlPanel =
    let
        animateToClosed =
            Animation.interrupt
                [ Animation.to styles.closed ]
                controlPanel.style
    in
        { controlPanel | status = Closed, style = animateToClosed }


show : ControlPanel -> ControlPanel
show controlPanel =
    let
        animateToOpen =
            Animation.interrupt
                [ Animation.to styles.open ]
                controlPanel.style
    in
        { controlPanel | status = Open, style = animateToOpen }


updateStyle : Animation.Msg -> ControlPanel -> ControlPanel
updateStyle msg controlPanel =
    { controlPanel | style = Animation.update msg controlPanel.style }
