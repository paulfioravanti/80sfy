module VideoPlayer.View.GifVideoPlayer exposing (view)

import Animation
import Gif exposing (GifUrl)
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
import Ports
import VideoPlayer.Model as Model exposing (VideoPlayer)
import VideoPlayer.Status as Status
import VideoPlayer.View.Msgs exposing (Msgs)
import VideoPlayer.View.Styles as Styles


view : Bool -> GifUrl -> Msgs msgs msg -> VideoPlayer -> Html msg
view audioPlaying gifUrl msgs ({ status } as videoPlayer) =
    let
        overlayVisible =
            audioPlaying && not (status == Status.playing)

        maybeOverlay =
            if overlayVisible then
                [ playerPausedOverlay ]

            else
                []
    in
    div
        (gifVideoPlayerAttributes overlayVisible msgs videoPlayer)
        (gifVideoPlayer gifUrl videoPlayer :: maybeOverlay)



-- PRIVATE


gifVideoPlayerAttributes :
    Bool
    -> Msgs msgs msg
    -> VideoPlayer
    -> List (Html.Attribute msg)
gifVideoPlayerAttributes overlayVisible { noOpMsg, portsMsg } { style, zIndex } =
    let
        animations =
            style
                |> Animation.render
                |> List.map fromUnstyled

        clickOnPlayAttribute =
            if overlayVisible then
                onClick (Ports.playVideosMsg portsMsg)

            else
                onClick noOpMsg

        rawVideoPlayerZIndex =
            Model.rawZIndex zIndex

        videoPlayerAttributes =
            [ attribute "data-name" "player-gif-container"
            , onDoubleClick (Ports.toggleFullscreenMsg portsMsg)
            , clickOnPlayAttribute
            , css [ Styles.gifContainer rawVideoPlayerZIndex ]
            ]
    in
    List.append animations videoPlayerAttributes


gifVideoPlayer : GifUrl -> VideoPlayer -> Html msg
gifVideoPlayer gifUrl { id, status } =
    let
        true =
            Encode.string "1"

        false =
            Encode.string "0"

        playingAttributes =
            if status == Status.playing then
                [ property "autoplay" true
                , property "loop" true
                ]

            else
                []

        rawVideoPlayerId =
            Model.rawId id

        rawGifUrl =
            Gif.rawUrl gifUrl

        playerAttributes =
            [ attribute "data-name" ("player-" ++ rawVideoPlayerId)
            , src rawGifUrl
            , css [ Styles.videoPlayer ]
            , property "muted" true
            , property "autopause" false
            ]
    in
    video (playerAttributes ++ playingAttributes) []


playerPausedOverlay : Html msg
playerPausedOverlay =
    let
        overlayText =
            "Click here to make this the active window and continue GIFs"
    in
    div
        [ attribute "data-name" "player-paused"
        , css [ Styles.videoPlayerPaused ]
        ]
        [ div
            [ attribute "data-name" "player-paused-content"
            , css [ Styles.videoPlayerPausedContent ]
            ]
            [ span [] [ text "[GIFs Paused]" ]
            , br [] []
            , br [] []
            , span []
                [ text overlayText ]
            ]
        ]
