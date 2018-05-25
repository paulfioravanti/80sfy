module ControlPanel
    exposing
        ( ControlPanel
        , animateStyle
        , determineVisibility
        , hide
        , init
        , setInUse
        , show
        , subscription
        , view
        )

import Animation exposing (px)
import Html.Styled as Html exposing (Html, div, i, img, video)
import Html.Styled.Attributes
    exposing
        ( attribute
        , class
        , css
        , fromUnstyled
        , src
        )
import Html.Styled.Events exposing (onMouseEnter, onMouseLeave)
import Mouse
import Msg
    exposing
        ( Msg
            ( CountdownToHideControlPanel
            , HideControlPanel
            , ShowControlPanel
            , UseControlPanel
            )
        )
import Styles
import Task
import Time


type alias ControlPanel =
    { inUse : Bool
    , secondsOpen : Int
    , style : Animation.State
    , visible : Bool
    }


type alias Styles =
    { hidden : List Animation.Property
    , visible : List Animation.Property
    }


animateStyle : Animation.Msg -> ControlPanel -> ControlPanel
animateStyle msg controlPanel =
    { controlPanel | style = Animation.update msg controlPanel.style }


determineVisibility : ControlPanel -> ( ControlPanel, Cmd Msg )
determineVisibility controlPanel =
    let
        timeoutSeconds =
            2
    in
        if controlPanel.secondsOpen > timeoutSeconds then
            ( { controlPanel | secondsOpen = 0 }
            , Task.perform HideControlPanel (Task.succeed ())
            )
        else
            ( { controlPanel | secondsOpen = controlPanel.secondsOpen + 1 }
            , Cmd.none
            )


hide : ControlPanel -> ControlPanel
hide controlPanel =
    let
        animateToHidden =
            Animation.interrupt
                [ Animation.to styles.hidden ]
                controlPanel.style
    in
        { controlPanel | style = animateToHidden, visible = False }


init : ControlPanel
init =
    { inUse = False
    , secondsOpen = 0
    , style =
        -- FIXME
        -- Animation.style styles.hidden
        Animation.style styles.visible
        -- FIXME
        -- , visible = False
    , visible = True
    }


setInUse : Bool -> ControlPanel -> ControlPanel
setInUse bool controlPanel =
    { controlPanel | inUse = bool }


show : ControlPanel -> ControlPanel
show controlPanel =
    let
        animateToVisible =
            Animation.interrupt
                [ Animation.to styles.visible ]
                controlPanel.style
    in
        { controlPanel | style = animateToVisible, visible = True }


subscription : ControlPanel -> Sub Msg
subscription controlPanel =
    if controlPanel.visible && not controlPanel.inUse then
        Time.every Time.second CountdownToHideControlPanel
    else
        Mouse.moves (\_ -> ShowControlPanel)


styles : Styles
styles =
    { hidden = [ Animation.left (px -220.0) ]
    , visible = [ Animation.left (px 0.0) ]
    }


view : ControlPanel -> Html Msg
view controlPanel =
    let
        animations =
            controlPanel.style
                |> Animation.render
                |> List.map fromUnstyled
    in
        div
            (animations
                ++ [ css [ Styles.controlPanel ]
                   , attribute "data-name" "control-panel"
                   , onMouseEnter (UseControlPanel True)
                   , onMouseLeave (UseControlPanel False)
                   ]
            )
            [ div
                [ css [ Styles.controlPanelContent ]
                , attribute "data-name" "panel-content"
                ]
                [ logo
                , trackInfo
                , div
                    [ css [ Styles.controls ]
                    , attribute "data-name" "controls"
                    ]
                    [ div
                        [ css [ Styles.controlButton ]
                        , attribute "data-name" "mute-unmute"
                        ]
                        [ div [ css [ Styles.controlIconBackground ] ]
                            []
                        , i
                            [ css [ Styles.controlIcon ]
                            , class "fas fa-volume-up"
                            ]
                            []
                        ]
                    , div
                        [ css [ Styles.controlButton ]
                        , attribute "data-name" "play-pause"
                        ]
                        []
                    , div
                        [ css [ Styles.controlButton ]
                        , attribute "data-name" "next-track"
                        ]
                        []
                    , div
                        [ css [ Styles.controlButton ]
                        , attribute "data-name" "fullscreen"
                        ]
                        []
                    ]
                ]
            ]


logo : Html msg
logo =
    div
        [ css [ Styles.logo ]
        , attribute "data-name" "logo"
        ]
        [ div [ css [ Styles.logoImageBackground ] ]
            []
        , img
            [ css [ Styles.logoImage ]
            , src "assets/logo.png"
            , attribute "data-name" "logo-image"
            ]
            []
        ]


trackInfo : Html msg
trackInfo =
    div
        [ css [ Styles.trackInfo ]
        , attribute "data-name" "track-info"
        ]
        []
