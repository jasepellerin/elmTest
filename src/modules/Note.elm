module Note exposing (Note, view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import Time exposing (..)



-- NOTE


type alias Note =
    { title : String
    , id : String
    , content : String
    , timeCreated : Posix
    }



-- VIEW


view : Zone -> Note -> Html msg
view timeZone model =
    let
        postDate =
            getHumanReadableDate model.timeCreated timeZone

        postTime =
            getHumanReadableTime model.timeCreated timeZone
    in
    article
        []
        [ h1 [] [ text model.title ]
        , small [] [ text ("Created " ++ postDate ++ " "), time [ datetime postTime ] [ text postTime ] ]
        , p [] [ text model.content ]
        ]


getHumanReadableDate : Posix -> Zone -> String
getHumanReadableDate createdTime timeZone =
    toEnglishMonth (toMonth timeZone createdTime) ++ " " ++ String.fromInt (toDay timeZone createdTime)


getHumanReadableTime : Posix -> Zone -> String
getHumanReadableTime createdTime timeZone =
    toTwoDigitString (toHour timeZone createdTime) ++ ":" ++ toTwoDigitString (toMinute timeZone createdTime)


toTwoDigitString : Int -> String
toTwoDigitString int =
    case int < 10 of
        True ->
            "0" ++ String.fromInt int

        False ->
            String.fromInt int


toEnglishMonth : Month -> String
toEnglishMonth month =
    case month of
        Jan ->
            "january"

        Feb ->
            "february"

        Mar ->
            "march"

        Apr ->
            "april"

        May ->
            "may"

        Jun ->
            "june"

        Jul ->
            "july"

        Aug ->
            "august"

        Sep ->
            "september"

        Oct ->
            "october"

        Nov ->
            "november"

        Dec ->
            "december"
