module AudioPlayer.Model exposing
    ( AudioPlayer
    , init
    , isMuted
    , isPlaying
    )

import AudioPlayer.Status as Status exposing (Status)


type alias AudioPlayer =
    { id : String
    , playlist : List Int
    , playlistLength : Int
    , soundCloudIframeUrl : String
    , status : Status
    , volume : Int
    }


init : String -> AudioPlayer
init soundCloudPlaylistUrl =
    { id = "track-player"
    , playlist = []
    , playlistLength = 0
    , soundCloudIframeUrl = iframeUrl soundCloudPlaylistUrl
    , status = Status.Paused
    , volume = 80
    }


iframeUrl : String -> String
iframeUrl soundCloudPlaylistUrl =
    "https://w.soundcloud.com/player/"
        ++ "?url="
        ++ soundCloudPlaylistUrl
        ++ "&auto_play=false"
        ++ "&buying=true"
        ++ "&liking=true"
        ++ "&download=true"
        ++ "&sharing=true"
        ++ "&show_artwork=true"
        ++ "&show_comments=false"
        ++ "&show_playcount=false"
        ++ "&show_user=false"
        ++ "&hide_related=false"
        ++ "&visual=false"
        ++ "&callback=true"


isMuted : AudioPlayer -> Bool
isMuted { status } =
    case status of
        Status.Muted _ ->
            True

        _ ->
            False


isPlaying : AudioPlayer -> Bool
isPlaying { status } =
    case status of
        Status.Playing ->
            True

        Status.Muted Status.Playing ->
            True

        _ ->
            False
