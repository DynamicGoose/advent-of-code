module Main where

main :: IO ()
main = do
  input <- readFile "input.txt"
  let result = part_1 input
  putStr result

part_1 :: String -> Integer
part_1 input = do
    let input_diagonal = input in


diagonals :: String -> [String]
diagonals =
