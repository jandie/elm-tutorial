module Main exposing (main)

import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import List exposing (..)


type alias Model =
    { count : Int }


init : ( Model, Cmd Msg )
init =
    ( { count = 0 }
    , Cmd.none
    )


type Msg
    = Increment


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( case msg of
        Increment ->
            incrementByList model <| List.repeat 50000 5001561
    , Cmd.none
    )

incrementByList : Model -> List Int -> Model
incrementByList model numbers =
    case numbers of
        [] ->
            model

        x :: xs ->
            incrementByList (incrementModel model x) xs
            -- incrementModel (incrementByList model xs) x

incrementModel : Model -> Int -> Model
incrementModel model number =
    { model | count = model.count + number }


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Increment ] [ text "+1" ]
        , div [] [ text <| toString model.count ]
        , div [] [ List.repeat 1000000 5001561  
            |> myFoldl (::) []
            |> List.maximum
            |> toString
            |> text]
        ]

myFoldl : (a -> b -> b) -> b -> List a -> b
myFoldl func acc list =
  case list of
    [] ->
      acc

    x :: xs ->
      myFoldl func (func x acc) xs


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
