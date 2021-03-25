module VideoPlayer.View exposing (view)

import Gif exposing (GifUrl)
import Html.Styled exposing (Html)
import RemoteData
import VideoPlayer.Model exposing (VideoPlayer)
import VideoPlayer.View.GifVideoPlayer as GifVideoPlayer
import VideoPlayer.View.ParentMsgs exposing (ParentMsgs)


view : ParentMsgs msgs msg -> Bool -> VideoPlayer -> Html msg
view parentMsgs audioPlaying videoPlayer =
    let
        gifUrl : GifUrl
        gifUrl =
            case videoPlayer.gifUrl of
                RemoteData.Success url ->
                    url

                _ ->
                    videoPlayer.fallbackGifUrl
    in
    GifVideoPlayer.view parentMsgs audioPlaying gifUrl videoPlayer
