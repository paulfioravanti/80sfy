module AudioPlayer.Model exposing (AudioPlayer, AudioPlayerId, init, rawId)

import AudioPlayer.Status as Status exposing (Status)


type AudioPlayerId
    = AudioPlayerId String


type alias AudioPlayer =
    { id : AudioPlayerId
    , playlist : List Int
    , playlistLength : Int
    , soundCloudIframeUrl : String
    , status : Status
    , volume : Int
    }


init : String -> AudioPlayer
init soundCloudPlaylistUrl =
    { id = AudioPlayerId "track-player"
    , playlist = []
    , playlistLength = 0
    , soundCloudIframeUrl = iframeUrl soundCloudPlaylistUrl
    , status = Status.paused
    , volume = 80
    }


rawId : AudioPlayerId -> String
rawId (AudioPlayerId rawIdValue) =
    rawIdValue



-- PRIVATE


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
