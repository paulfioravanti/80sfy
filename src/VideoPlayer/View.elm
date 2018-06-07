module VideoPlayer.View exposing (view)

import Animation
import Html.Styled as Html exposing (Html, br, div, span, text, video)
import Html.Styled.Attributes
    exposing
        ( attribute
        , css
        , fromUnstyled
        , property
        , src
        )
import Html.Styled.Events exposing (onClick, onDoubleClick)
import Json.Encode as Encode
import Msg exposing (Msg(ToggleFullScreen, ToggleGifRotation))
import RemoteData exposing (RemoteData(Success))
import VideoPlayer.Model exposing (VideoPlayer)
import VideoPlayer.MsgConfig exposing (MsgConfig)
import VideoPlayer.Styles as Styles


view : MsgConfig msg -> VideoPlayer -> Html Msg
view msgConfig videoPlayer =
    let
        gifUrl =
            case videoPlayer.gifUrl of
                Success gifUrl ->
                    gifUrl

                _ ->
                    videoPlayer.fallbackGifUrl

        childElements =
            gifVideoPlayer gifUrl videoPlayer
                :: if not videoPlayer.playing then
                    [ playerPausedOverlay ]
                   else
                    []
    in
        div (attributes videoPlayer) childElements


attributes : VideoPlayer -> List (Html.Attribute Msg)
attributes player =
    let
        animations =
            player.style
                |> Animation.render
                |> List.map fromUnstyled

        attributes =
            [ css [ Styles.gifContainer player.zIndex ]
            , attribute "data-name" "player-gif-container"
            , onDoubleClick ToggleFullScreen
            ]
    in
        List.append animations attributes


gifVideoPlayer : String -> VideoPlayer -> Html Msg
gifVideoPlayer gifUrl videoPlayer =
    let
        true =
            Encode.string "1"

        false =
            Encode.string "0"

        playingAttributes =
            if videoPlayer.playing then
                [ property "autoplay" true
                , property "loop" true
                , property "muted" true
                , property "autopause" false
                ]
            else
                [ property "muted" true
                , property "autopause" false
                ]

        attributes =
            [ src gifUrl
            , css [ Styles.videoPlayer ]
            , attribute "data-name" ("player-" ++ videoPlayer.id)
            , onClick (ToggleGifRotation True)
            ]
    in
        video (attributes ++ playingAttributes) []


playerPausedOverlay : Html msg
playerPausedOverlay =
    div
        [ css [ Styles.videoPlayerPaused ]
        , attribute "data-name" "player-paused"
        ]
        [ div
            [ css [ Styles.videoPlayerPausedContent ]
            , attribute "data-name" "player-paused-content"
            ]
            [ span [] [ text "[GIFs Paused]" ]
            , br [] []
            , br [] []
            , span []
                [ text """Click here to make this the
                               active window and continue GIFs"""
                ]
            ]
        ]
