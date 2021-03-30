module Config.Update exposing (ParentMsgs, update)

import AudioPlayer
import Config.Model as Model exposing (Config)
import Config.Msg as Msg exposing (Msg)
import Config.Task as Task
import Gif exposing (GifDisplayIntervalSeconds)
import Http exposing (Error)
import Ports
import SoundCloud exposing (SoundCloudPlaylistUrl)
import Tag exposing (Tag)
import VideoPlayer exposing (VideoPlayerId)


type alias ParentMsgs msgs msg =
    { msgs
        | audioPlayerMsg : AudioPlayer.Msg -> msg
        , configMsg : Msg -> msg
        , videoPlayerMsg : VideoPlayer.Msg -> msg
    }


update : ParentMsgs msgs msg -> Msg -> Config -> ( Config, Cmd msg )
update parentMsgs msg secretConfig =
    case msg of
        Msg.InitTags tagList ->
            ( { secretConfig | tags = List.map Tag.tag tagList }, Cmd.none )

        Msg.RandomTagGenerated videoPlayerId tag ->
            let
                randomGifUrlFetchedMsg : Result Error String -> msg
                randomGifUrlFetchedMsg =
                    VideoPlayer.randomGifUrlFetchedMsg
                        parentMsgs.videoPlayerMsg
                        videoPlayerId

                fetchRandomGifUrl : Cmd msg
                fetchRandomGifUrl =
                    Gif.fetchRandomGifUrl
                        randomGifUrlFetchedMsg
                        secretConfig.giphyApiKey
                        tag
            in
            ( secretConfig, fetchRandomGifUrl )

        Msg.Save soundCloudPlaylistUrl tagsString gifDisplayIntervalSeconds ->
            let
                updatedConfig : Config
                updatedConfig =
                    Model.update
                        soundCloudPlaylistUrl
                        tagsString
                        gifDisplayIntervalSeconds
                        secretConfig

                cmd : Cmd msg
                cmd =
                    if
                        soundCloudPlaylistUrl
                            == secretConfig.soundCloudPlaylistUrl
                    then
                        Cmd.none

                    else
                        AudioPlayer.performAudioPlayerReset
                            parentMsgs.audioPlayerMsg
                            soundCloudPlaylistUrl
            in
            ( updatedConfig, cmd )

        Msg.TagsFetched (Ok rawTags) ->
            let
                tags : List Tag
                tags =
                    List.map Tag.tag rawTags

                generateRandomTagForVideoPlayer : VideoPlayerId -> Cmd msg
                generateRandomTagForVideoPlayer videoPlayerId =
                    let
                        randomTagGeneratedMsg : Tag -> msg
                        randomTagGeneratedMsg =
                            Msg.randomTagGenerated
                                parentMsgs.configMsg
                                videoPlayerId
                    in
                    Tag.generateRandomTag randomTagGeneratedMsg tags

                performInitSecretConfigTags : Cmd msg
                performInitSecretConfigTags =
                    Task.performInitTags
                        parentMsgs.configMsg
                        rawTags
            in
            ( { secretConfig | tags = tags }
            , Cmd.batch
                [ generateRandomTagForVideoPlayer (VideoPlayer.id "1")
                , generateRandomTagForVideoPlayer (VideoPlayer.id "2")
                , performInitSecretConfigTags
                ]
            )

        Msg.TagsFetched (Err error) ->
            ( secretConfig, Ports.logError "Fetching Tags Failed" error )

        Msg.ToggleInactivityPauseOverride ->
            let
                toggledOverrideInactivityPause : Bool
                toggledOverrideInactivityPause =
                    not secretConfig.overrideInactivityPause
            in
            ( { secretConfig
                | overrideInactivityPause = toggledOverrideInactivityPause
              }
            , Cmd.none
            )

        Msg.ToggleVisibility ->
            ( { secretConfig | visible = not secretConfig.visible }
            , Cmd.none
            )

        Msg.UpdateGifDisplaySeconds seconds ->
            let
                gifDisplayIntervalSeconds : GifDisplayIntervalSeconds
                gifDisplayIntervalSeconds =
                    Gif.updateDisplayIntervalSeconds
                        seconds
                        secretConfig.gifDisplayIntervalSeconds
            in
            ( { secretConfig
                | gifDisplayIntervalSeconds = gifDisplayIntervalSeconds
              }
            , Cmd.none
            )

        Msg.UpdateSoundCloudPlaylistUrl rawSoundCloudPlaylistUrl ->
            let
                soundCloudPlaylistUrl : SoundCloudPlaylistUrl
                soundCloudPlaylistUrl =
                    SoundCloud.playlistUrl rawSoundCloudPlaylistUrl
            in
            ( { secretConfig | soundCloudPlaylistUrl = soundCloudPlaylistUrl }
            , Cmd.none
            )

        Msg.UpdateTags tags ->
            ( { secretConfig | tags = Tag.tagList tags }
            , Cmd.none
            )
