module VideoPlayer.View.GifVideoPlayer exposing (view)

import Gif exposing (GifUrl)
import Html.Styled as Html exposing (Html, br, div, span, text, video)
import Html.Styled.Attributes exposing (attribute, css, property, src)
import Html.Styled.Events exposing (onClick, onDoubleClick)
import Json.Encode as Encode exposing (Value)
import Ports
import VideoPlayer.Animation as Animation
import VideoPlayer.Model as Model exposing (VideoPlayer)
import VideoPlayer.Status as Status
import VideoPlayer.VideoPlayerId as VideoPlayerId
import VideoPlayer.View.ParentMsgs exposing (ParentMsgs)
import VideoPlayer.View.Styles as Styles


view : ParentMsgs msgs msg -> Bool -> GifUrl -> VideoPlayer -> Html msg
view parentMsgs audioPlaying gifUrl ({ status } as videoPlayer) =
    let
        overlayVisible : Bool
        overlayVisible =
            audioPlaying && not (status == Status.playing)

        maybeOverlay : List (Html msg)
        maybeOverlay =
            if overlayVisible then
                [ playerPausedOverlay ]

            else
                []
    in
    div
        (gifVideoPlayerAttributes overlayVisible parentMsgs videoPlayer)
        (gifVideoPlayer gifUrl videoPlayer :: maybeOverlay)



-- PRIVATE


gifVideoPlayerAttributes :
    Bool
    -> ParentMsgs msgs msg
    -> VideoPlayer
    -> List (Html.Attribute msg)
gifVideoPlayerAttributes overlayVisible { noOpMsg, portsMsg } { style, zIndex } =
    let
        animations : List (Html.Attribute msg)
        animations =
            Animation.animations style

        onClickMsg : msg
        onClickMsg =
            if overlayVisible then
                portsMsg Ports.playVideosMsg

            else
                noOpMsg

        rawVideoPlayerZIndex : Int
        rawVideoPlayerZIndex =
            Model.rawZIndex zIndex

        videoPlayerAttributes : List (Html.Attribute msg)
        videoPlayerAttributes =
            [ attribute "data-name" "player-gif-container"
            , onDoubleClick (portsMsg Ports.toggleFullscreenMsg)
            , onClick onClickMsg
            , css [ Styles.gifContainer rawVideoPlayerZIndex ]
            ]
    in
    List.append animations videoPlayerAttributes


gifVideoPlayer : GifUrl -> VideoPlayer -> Html msg
gifVideoPlayer gifUrl { id, status } =
    let
        true : Value
        true =
            Encode.string "1"

        false : Value
        false =
            Encode.string "0"

        playingAttributes : List (Html.Attribute msg)
        playingAttributes =
            if status == Status.playing then
                [ property "autoplay" true
                , property "loop" true
                ]

            else
                []

        rawVideoPlayerId : String
        rawVideoPlayerId =
            VideoPlayerId.rawId id

        rawGifUrl : String
        rawGifUrl =
            Gif.rawUrl gifUrl

        playerAttributes : List (Html.Attribute msg)
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
        overlayText : String
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
