module Main exposing (main)

import Animation
import Html exposing (Html, text, div, h1, img, p, video)
import Html.Attributes exposing (attribute, property, src, style)
import Http exposing (Error)
import Json.Decode as Decode
import Json.Encode as Encode
import Random
import RemoteData exposing (RemoteData(..), WebData)
import Task
import Time exposing (Time)


tags : List String
tags =
    [ "80s"
    , "1980"
    , "80s art"
    , "80s animation"
    , "80s tv"
    , "80s food"
    , "80s movie"
    , "80s music"
    , "80s miami"
    , "80s fashion"
    , "80s scifi"
    , "80s anime"
    , "80s video games"
    , "80s video"
    , "vhs"
    , "synthwave"
    , "tron"
    , "grid"
    , "nes"
    , "8bit"
    , "pixel"
    , "neon"
    , "geometry"
    , "kidmograph"
    ]



---- MODEL ----


type VideoPlayer
    = Player1
    | Player2


type alias Model =
    { player1GifUrl : WebData String
    , player1Style : Animation.State
    , player2GifUrl : WebData String
    , player2Style : Animation.State
    , visiblePlayer : VideoPlayer
    }


init : ( Model, Cmd Msg )
init =
    let
        model =
            { player1GifUrl = NotRequested
            , player1Style =
                Animation.style [ Animation.opacity 1 ]
            , player2Style =
                Animation.style [ Animation.opacity 0 ]
            , player2GifUrl = NotRequested
            , visiblePlayer = Player1
            }
    in
        ( { model | player1GifUrl = Requesting }
        , generateRandomGif
        )



---- COMMANDS ----


generateRandomGif : Cmd Msg
generateRandomGif =
    let
        index =
            Random.int 1 (List.length tags - 1)
    in
        index
            |> Random.generate GenerateRandomTagIndex


generateRandomTag : Int -> String
generateRandomTag numberOfMembers =
    tags
        |> List.drop numberOfMembers
        |> List.head
        |> Maybe.withDefault "80s"


fetchRandomGif : Int -> Cmd Msg
fetchRandomGif index =
    let
        tag =
            generateRandomTag index

        host =
            "https://api.giphy.com"

        path =
            "/v1/gifs/random"

        apiKey =
            "api_key=JASRREAAILxOCCf0awYF89DVBaH2BPl3"

        url =
            host
                ++ path
                ++ "?"
                ++ apiKey
                ++ "&tag="
                ++ tag
    in
        decodeGifUrl
            |> Http.get url
            |> Http.send GetRandomGif



---- DECODERS ----


decodeGifUrl : Decode.Decoder String
decodeGifUrl =
    Decode.at [ "data", "image_mp4_url" ] Decode.string



---- UPDATE ----


type Msg
    = GetRandomGif (Result Error String)
    | GetNextGif Time
    | GenerateRandomTagIndex Int
    | UpdatePage Model
    | NoOp
    | Animate Animation.Msg
    | FadeOutFadeIn ()


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Animate msg ->
            ( { model
                | player1Style = Animation.update msg model.player1Style
              }
            , Cmd.none
            )

        FadeOutFadeIn () ->
            ( { model
                | player1Style =
                    Animation.interrupt
                        [ Animation.to
                            [ Animation.opacity 0 ]
                        , Animation.to
                            [ Animation.opacity 1 ]
                        ]
                        model.player1Style
              }
            , Cmd.none
            )

        GetNextGif time ->
            ( model
            , Cmd.batch
                [ generateRandomGif
                , Task.succeed ()
                    |> Task.perform FadeOutFadeIn
                ]
            )

        GetRandomGif (Ok imageUrl) ->
            ( { model | player1GifUrl = Success imageUrl }, Cmd.none )

        GetRandomGif (Err error) ->
            ( model, Cmd.none )

        GenerateRandomTagIndex index ->
            ( model, fetchRandomGif index )

        _ ->
            ( model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    case model.player1GifUrl of
        NotRequested ->
            p [] [ text "" ]

        Requesting ->
            p [] [ text "" ]

        Success player1GifUrl ->
            div [ attribute "data-name" "container" ]
                [ div (Animation.render model.player1Style)
                    [ video
                        [ src player1GifUrl
                        , attribute "data-name" "player-1"
                        , style
                            [ ( "height", "100%" )
                            , ( "maxWidth", "100%" )
                            , ( "width", "100%" )
                            , ( "margin", "0 auto" )
                            ]
                        , property "autoplay" (Encode.string "true")
                        , property "loop" (Encode.string "true")
                        ]
                        []
                    ]
                , div [ style [ ( "display", "none" ) ] ]
                    [ video
                        [ src player1GifUrl
                        , attribute "data-name" "player-2"
                        , style
                            [ ( "height", "100%" )
                            , ( "maxWidth", "100%" )
                            , ( "width", "100%" )
                            , ( "margin", "0 auto" )
                            ]
                        , property "autoplay" (Encode.string "true")
                        , property "loop" (Encode.string "true")
                        ]
                        []
                    ]
                ]

        _ ->
            p [] [ text "Something went wrong" ]



---- SUBSCRIPTIONS ----


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Time.every (7 * Time.second) GetNextGif
        , Animation.subscription Animate [ model.player1Style ]
        ]



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = subscriptions
        }
