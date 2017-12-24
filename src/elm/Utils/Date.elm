module Utils.Date exposing (dateToString, monthToString)

import Date exposing (Date, Month)


dateToString : Date -> String
dateToString date =
    (Date.month date
        |> monthToInt
        |> toString
        |> String.padLeft 2 '0'
    )
        ++ "."
        ++ (Date.day date
                |> toString
                |> String.padLeft 2 '0'
           )
        ++ "."
        ++ (Date.year date
                |> toString
                |> String.padLeft 4 '0'
           )


monthToInt : Month -> Int
monthToInt month =
    case month of
        Date.Jan ->
            1

        Date.Feb ->
            2

        Date.Mar ->
            3

        Date.Apr ->
            4

        Date.May ->
            5

        Date.Jun ->
            6

        Date.Jul ->
            7

        Date.Aug ->
            8

        Date.Sep ->
            9

        Date.Oct ->
            10

        Date.Nov ->
            11

        Date.Dec ->
            12


monthToString : Month -> String
monthToString month =
    case month of
        Date.Jan ->
            "January"

        Date.Feb ->
            "February"

        Date.Mar ->
            "March"

        Date.Apr ->
            "April"

        Date.May ->
            "May"

        Date.Jun ->
            "June"

        Date.Jul ->
            "July"

        Date.Aug ->
            "August"

        Date.Sep ->
            "September"

        Date.Oct ->
            "October"

        Date.Nov ->
            "November"

        Date.Dec ->
            "December"
