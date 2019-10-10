module TimeHelpers exposing (getHumanReadableDate, getHumanReadableTime, toEnglishMonth, toTwoDigitString)

import Time exposing (..)


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
