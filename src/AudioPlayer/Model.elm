module AudioPlayer.Model
    exposing
        ( AudioPlayer
        , Status(..)
        , init
        , isMuted
        , isPlaying
        )


type Status
    = Playing
    | Paused
    | Muted Status


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
    , status = Paused
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
        Muted _ ->
            True

        _ ->
            False


isPlaying : AudioPlayer -> Bool
isPlaying { status } =
    case status of
        Playing ->
            True

        Muted Playing ->
            True

        _ ->
            False
