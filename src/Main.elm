module Main exposing (main)

import Animation
import Html.Styled as Html
import Model exposing (Model)
import Mouse
import Msg
    exposing
        ( Msg
            ( Animate
            , CrossFade
            , HideControlPanel
            , ShowControlPanel
            , Tick
            )
        )
import Time exposing (Time)
import Update
import View


subscriptions : Model -> Sub Msg
subscriptions { controlPanel, controlPanelMouseOver, player1 } =
    let
        menuToggle =
            if controlPanel.visible && not controlPanelMouseOver then
                Time.every Time.second Tick
            else
                Mouse.moves (\_ -> ShowControlPanel)
    in
        Sub.batch
            [ Time.every (4 * Time.second) CrossFade
            , Animation.subscription Animate [ player1.style, controlPanel.style ]
            , menuToggle
            ]


main : Program Never Model Msg
main =
    Html.program
        { view = View.view
        , init = Model.init
        , update = Update.update
        , subscriptions = subscriptions
        }



-- module Main exposing (..)
-- import Html exposing (..)
-- import Html.Attributes exposing (..)
-- import Html.Events exposing (..)
-- import Animation exposing (px)
-- type alias Model =
--     { style : Animation.State
--     }
-- type Msg
--     = Show
--     | Hide
--     | Animate Animation.Msg
-- type alias Styles =
--     { open : List Animation.Property
--     , closed : List Animation.Property
--     }
-- standardEasing =
--     Animation.easing
--         { duration = 10000
--         , ease = identity
--         }
-- styles : Styles
-- styles =
--     { open =
--         [ Animation.left (px 0.0)
--         , Animation.opacity 1.0
--         ]
--     , closed =
--         [ Animation.left (px -355.0)
--         , Animation.opacity 1.0
--         ]
--     }
-- update : Msg -> Model -> ( Model, Cmd Msg )
-- update action model =
--     case action of
--         Show ->
--             ( { model
--                 | style =
--                     Animation.interrupt
--                         [ Animation.to styles.open
--                         ]
--                         model.style
--               }
--             , Cmd.none
--             )
--         Hide ->
--             ( { model
--                 | style =
--                     Animation.interrupt
--                         [ Animation.to styles.closed
--                         ]
--                         model.style
--               }
--             , Cmd.none
--             )
--         Animate animMsg ->
--             ( { model
--                 | style = Animation.update animMsg model.style
--               }
--             , Cmd.none
--             )
-- view : Model -> Html Msg
-- view model =
--     div
--         [ onMouseEnter Show
--         , onMouseLeave Hide
--         , style
--             [ ( "position", "absolute" )
--             , ( "left", "0px" )
--             , ( "top", "0px" )
--             , ( "width", "350px" )
--             , ( "height", "100%" )
--             , ( "border", "2px dashed #AAA" )
--             ]
--         ]
--         [ h1 [ style [ ( "padding", "25px" ) ] ]
--             [ text "Hover here to see menu!" ]
--         , div
--             (Animation.render model.style
--                 ++ [ style
--                         [ ( "position", "absolute" )
--                         , ( "top", "-2px" )
--                         , ( "margin-left", "-2px" )
--                         , ( "padding", "25px" )
--                         , ( "width", "300px" )
--                         , ( "height", "100%" )
--                         , ( "background-color", "rgb(58,40,69)" )
--                         , ( "color", "white" )
--                         , ( "border", "2px solid rgb(58,40,69)" )
--                         ]
--                    ]
--             )
--             [ h1 [] [ text "Hidden Menu" ]
--             , ul []
--                 [ li [] [ text "Some things" ]
--                 , li [] [ text "in a list" ]
--                 ]
--             ]
--         ]
-- subscriptions : Model -> Sub Msg
-- subscriptions model =
--     Animation.subscription Animate [ model.style ]
-- init : ( Model, Cmd Msg )
-- init =
--     ( { style = Animation.style styles.closed }
--     , Cmd.none
--     )
-- main : Program Never Model Msg
-- main =
--     Html.program
--         { init = init
--         , view = view
--         , update = update
--         , subscriptions = subscriptions
--         }
