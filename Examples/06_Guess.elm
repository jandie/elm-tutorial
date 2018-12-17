module Guess exposing (Model, Msg(..), main, model, update, view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


main : Program Never Model Msg
main =
    Html.beginnerProgram { model = model, update = update, view = view }


type alias RevealedWord =
    { pos : Int, text : String }


type alias Result =
    { text : String, isCorrect : Bool }


type alias Model =
    { word : String
    , guess : String
    , revealedWord : RevealedWord
    , result : Result
    , wordList : List String
    }


initialWordList : List String
initialWordList =
    [ "Banana"
    , "Kitten"
    , "Paperclip"
    , "Orangutan"
    , "Italic"
    , "Afternoon"
    ]


model : Model
model =
    Model "Saturday"
        ""
        (RevealedWord 1 "S")
        (Result "" False)
        initialWordList


type Msg
    = Answer String
    | Reveal
    | Check
    | Another


update : Msg -> Model -> Model
update msg model =
    case msg of
        Answer txt ->
            { model | guess = txt }

        Reveal ->
            { model | revealedWord = revealAndIncrement model }

        Check ->
            { model | result = checkResult model }

        Another ->
            let
                newWord =
                    getNewWord model
            in
            { model
                | word = newWord
                , guess = ""
                , revealedWord = RevealedWord 1 (firstLetter newWord)
                , wordList = changeWordList model.wordList
                , result = Result "" False
            }


getNewWord : Model -> String
getNewWord { wordList } =
    wordList
        |> List.take 1
        |> String.concat


changeWordList : List String -> List String
changeWordList words =
    List.drop 1 words


firstLetter : String -> String
firstLetter word =
    String.slice 0 1 word


checkResult : Model -> Result
checkResult { word, guess } =
    if String.toLower word == String.toLower guess then
        Result "You got it" True

    else
        Result "Nope" False


revealAndIncrement : Model -> RevealedWord
revealAndIncrement model =
    { text = revealLetter model
    , pos = revealPos model
    }


revealLetter : Model -> String
revealLetter { revealedWord, word } =
    String.slice 0 (revealedWord.pos + 1) word


revealPos : Model -> Int
revealPos { revealedWord, word } =
    if revealedWord.pos < String.length word then
        revealedWord.pos + 1

    else
        revealedWord.pos


genResult : Model -> Html Msg
genResult { result } =
    let
        ( txt, clr ) =
            if String.isEmpty result.text then
                ( "", "black" )

            else if result.isCorrect then
                ( result.text, "forestgreen" )

            else
                ( result.text, "tomato" )
    in
    p
        [ style
            [ ( "color", clr )
            , ( "font-size", "5em" )
            , ( "font-family", "impact" )
            ]
        ]
        [ text txt ]


mainStyle : Attribute Msg
mainStyle =
    style
        [ ( "text-align", "center" )
        , ( "font-size", "2em" )
        , ( "font-family", "monospace" )
        ]


view : Model -> Html Msg
view model =
    div [ mainStyle ]
        [ h2 []
            [ text
                ("I'm thinking of a word that starts with "
                    ++ model.revealedWord.text
                    ++ " and has "
                    ++ toString (String.length model.word)
                    ++ " letters."
                )
            ]
        , input [ placeholder "Type your guess", onInput Answer ] []
        , p []
            [ button [ onClick Reveal ] [ text "Reveal letter" ]
            , button [ onClick Check ] [ text "Submit answer" ]
            , button [ onClick Another ] [ text "Another word" ]
            ]
        , div [] [ genResult model ]
        ]
