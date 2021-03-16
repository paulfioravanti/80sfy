module VideoPlayer.VideoPlayerId exposing (VideoPlayerId, id, rawId)


type VideoPlayerId
    = VideoPlayerId String


id : String -> VideoPlayerId
id rawIdString =
    VideoPlayerId rawIdString


rawId : VideoPlayerId -> String
rawId (VideoPlayerId rawIdString) =
    rawIdString
