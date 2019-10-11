module EditableNote exposing (view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import Note exposing (Note)


type alias UpdateHandler msg =
    Int -> Note -> msg



-- VIEW


view : UpdateHandler msg -> Note -> Html msg
view editHandler model =
    article
        [ id (String.fromInt model.id) ]
        [ div [ class "title" ]
            [ input [ value model.title, onInput (titleChangeHandler editHandler model) ] []
            , hr [] []
            ]
        , textarea [ value model.content, onInput (contentChangeHandler editHandler model) ] []
        ]


titleChangeHandler : UpdateHandler msg -> Note -> String -> msg
titleChangeHandler editHandler model newTitle =
    editHandler model.id { model | title = newTitle }


contentChangeHandler : UpdateHandler msg -> Note -> String -> msg
contentChangeHandler editHandler model newContent =
    editHandler model.id { model | content = newContent }
