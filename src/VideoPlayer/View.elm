module VideoPlayer.View exposing (view)

import Html.Styled exposing (Html)
import RemoteData
import VideoPlayer.Model exposing (VideoPlayer)
import VideoPlayer.View.GifVideoPlayer as GifVideoPlayer
import VideoPlayer.View.Msgs exposing (Msgs)


view : Bool -> Msgs msgs msg -> VideoPlayer -> Html msg
view audioPlaying msgs videoPlayer =
    let
        gifUrl =
            case videoPlayer.gifUrl of
                RemoteData.Success url ->
                    url

                _ ->
                    videoPlayer.fallbackGifUrl
    in
    GifVideoPlayer.view audioPlaying gifUrl msgs videoPlayer
