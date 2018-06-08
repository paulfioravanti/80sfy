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
import MsgConfig exposing (MsgConfig)
import RemoteData exposing (RemoteData(Success))
import SecretConfig.Msg exposing (Msg(ToggleGifRotation))
import VideoPlayer.Model exposing (VideoPlayer)
import VideoPlayer.Msg exposing (Msg(ToggleFullScreen))
import VideoPlayer.Styles as Styles


view : MsgConfig msg -> VideoPlayer -> Html msg
view msgConfig videoPlayer =
    let
        gifUrl =
            case videoPlayer.gifUrl of
                Success gifUrl ->
                    gifUrl

                _ ->
                    videoPlayer.fallbackGifUrl

        childElements =
            gifVideoPlayer msgConfig gifUrl videoPlayer
                :: if not videoPlayer.playing then
                    [ playerPausedOverlay ]
                   else
                    []
    in
        div (attributes msgConfig videoPlayer) childElements


attributes : MsgConfig msg -> VideoPlayer -> List (Html.Attribute msg)
attributes msgConfig videoPlayer =
    let
        animations =
            videoPlayer.style
                |> Animation.render
                |> List.map fromUnstyled

        attributes =
            [ css [ Styles.gifContainer videoPlayer.zIndex ]
            , attribute "data-name" "player-gif-container"
            , onDoubleClick (msgConfig.videoPlayerMsg ToggleFullScreen)
            ]
    in
        List.append animations attributes


gifVideoPlayer : MsgConfig msg -> String -> VideoPlayer -> Html msg
gifVideoPlayer { secretConfigMsg } gifUrl videoPlayer =
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
            , onClick (secretConfigMsg (ToggleGifRotation True))
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
