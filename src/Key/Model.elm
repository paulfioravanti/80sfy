module Key.Model exposing (Key(..), fromString)


type Key
    = DownArrow
    | Escape
    | Other
    | RightArrow
    | Space
    | UpArrow


fromString : String -> Key
fromString string =
    case string of
        "Escape" ->
            Escape

        " " ->
            Space

        "ArrowUp" ->
            UpArrow

        "ArrowRight" ->
            RightArrow

        "ArrowDown" ->
            DownArrow

        _ ->
            Other
