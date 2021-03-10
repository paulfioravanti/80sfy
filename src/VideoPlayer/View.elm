module VideoPlayer.View exposing (Msgs, view)

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
import Port
import RemoteData
import VideoPlayer.Model as Model exposing (VideoPlayer)
import VideoPlayer.Status as Status
import VideoPlayer.Styles as Styles


type alias Msgs msgs msg =
    { msgs
        | noOpMsg : msg
        , portMsg : Port.Msg -> msg
    }


view : Bool -> Msgs msgs msg -> VideoPlayer -> Html msg
view audioPlaying msgs videoPlayer =
    let
        gifUrl =
            case videoPlayer.gifUrl of
                RemoteData.Success url ->
                    url

                _ ->
                    videoPlayer.fallbackGifUrl

        videoPlayerPaused =
            audioPlaying && not (videoPlayer.status == Status.playing)

        childElements =
            gifVideoPlayer gifUrl videoPlayer
                :: (if videoPlayerPaused then
                        [ playerPausedOverlay ]

                    else
                        []
                   )
    in
    div
        (attributes audioPlaying msgs videoPlayer)
        childElements



-- PRIVATE


attributes :
    Bool
    -> Msgs msgs msg
    -> VideoPlayer
    -> List (Html.Attribute msg)
attributes audioPlaying msgs videoPlayer =
    let
        { noOpMsg, portMsg } =
            msgs

        animations =
            videoPlayer.style
                |> Animation.render
                |> List.map fromUnstyled

        clickOnPlayAttribute =
            if audioPlaying && not (videoPlayer.status == Status.playing) then
                onClick (Port.playVideosParentMsg portMsg)

            else
                onClick noOpMsg

        rawVideoPlayerZIndex =
            Model.rawZIndex videoPlayer.zIndex

        videoPlayerAttributes =
            [ attribute "data-name" "player-gif-container"
            , onDoubleClick (Port.toggleFullscreenMsg portMsg)
            , clickOnPlayAttribute
            , css [ Styles.gifContainer rawVideoPlayerZIndex ]
            ]
    in
    List.append animations videoPlayerAttributes


gifVideoPlayer : GifUrl -> VideoPlayer -> Html msg
gifVideoPlayer gifUrl videoPlayer =
    let
        true =
            Encode.string "1"

        false =
            Encode.string "0"

        playingAttributes =
            [ property "muted" true
            , property "autopause" false
            ]
                ++ (if videoPlayer.status == Status.playing then
                        [ property "autoplay" true
                        , property "loop" true
                        ]

                    else
                        []
                   )

        rawVideoPlayerId =
            Model.rawId videoPlayer.id

        rawGifUrl =
            Gif.rawUrl gifUrl

        playerAttributes =
            [ attribute "data-name" ("player-" ++ rawVideoPlayerId)
            , src rawGifUrl
            , css [ Styles.videoPlayer ]
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
