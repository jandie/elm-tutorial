module AnotherHello exposing (checkStatus, main, statusesChecks)

import Html exposing (..)


checkStatus : Int -> String
checkStatus status =
    if status == 200 then
        "You got it"

    else if status == 404 then
        "Page not found"

    else
        "Unknown response"


statusesChecks : List String
statusesChecks =
    [ checkStatus 200
    , checkStatus 404
    , checkStatus 418
    ]


renderList : List String -> Html msg
renderList lst =
    lst
        |> createMapLi
        |> ul []


createMapLi : List String -> List (Html msg)
createMapLi lst =
    lst
        |> List.map (\l -> createLi l)


createLi : String -> Html msg
createLi str =
    li [] [ text str ]


main : Html msg
main =
    div []
        [ h1 [] [ text "List of statuses" ]
        , renderList statusesChecks
        ]
