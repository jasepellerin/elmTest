module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import EditableNote
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Note exposing (Note)
import Task
import Time


main : Program () Model Msg
main =
    Browser.document
        { init = init
        , subscriptions = subscriptions
        , update = update
        , view = view
        }



-- MODEL


type alias Model =
    { currentNewNoteId : Int
    , editingId : Int
    , notes : List Note.Note
    , zone : Time.Zone
    }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


init : () -> ( Model, Cmd Msg )
init =
    always
        ( { currentNewNoteId = 0
          , editingId = -1
          , notes =
                []
          , zone = Time.utc
          }
        , Task.perform AdjustTimeZone Time.here
        )



-- UPDATE


type Msg
    = AdjustTimeZone Time.Zone
    | AddNoteClick
    | AddNote Time.Posix
    | ChangeEditingId Int
    | FinishEditingNote
    | RemoveNote Int
    | UpdateNote Int Note


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AdjustTimeZone newZone ->
            ( { model | zone = newZone }, Cmd.none )

        AddNoteClick ->
            ( model, Task.perform AddNote Time.now )

        AddNote time ->
            update
                (ChangeEditingId
                    model.currentNewNoteId
                )
                { model
                    | notes = Note.init model.currentNewNoteId time :: model.notes
                    , currentNewNoteId = model.currentNewNoteId + 1
                }

        ChangeEditingId newId ->
            ( { model | notes = List.filter (checkNoteHasTitleOrContent newId) model.notes, editingId = newId }, Cmd.none )

        RemoveNote id ->
            ( { model | notes = List.filter (\x -> x.id /= id) model.notes }, Cmd.none )

        FinishEditingNote ->
            update (ChangeEditingId -1) model

        UpdateNote id newNote ->
            let
                noteReplacer : Note -> Note
                noteReplacer existingNote =
                    if existingNote.id == newNote.id then
                        newNote

                    else
                        existingNote

                newNotes =
                    List.map noteReplacer model.notes
            in
            ( { model | notes = newNotes }, Cmd.none )


checkNoteHasTitleOrContent : Int -> Note -> Bool
checkNoteHasTitleOrContent editingId note =
    (note.title /= "") || note.content /= "" || note.id == editingId



-- VIEW


view : Model -> Browser.Document Msg
view model =
    { body =
        [ header []
            [ h1 []
                [ text "notorious" ]
            , button
                [ onClick AddNoteClick ]
                [ text "Add note" ]
            ]
        , main_ [] (List.map (displayNote model) model.notes)
        ]
    , title = "notorious"
    }


displayNote : Model -> Note -> Html Msg
displayNote model note =
    let
        editableConfig =
            EditableNote.Config FinishEditingNote UpdateNote

        noteConfig =
            Note.Config ChangeEditingId RemoveNote
    in
    if note.id == model.editingId then
        EditableNote.view editableConfig note

    else
        Note.view noteConfig model.zone note
