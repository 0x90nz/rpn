import Text.Read

convertToInt :: String -> Maybe Int
convertToInt s = readMaybe s :: Maybe Int

-- Takes a token and evaluates it in the context of the 'stack' provided
-- just ignores any invalid tokens
evalToken :: [Int] -> String -> [Int]
evalToken (a:b:xs) s | s == "+"  = b + a : xs
                     | s == "-"  = b - a : xs
                     | s == "*"  = b * a : xs
                     | s == "/"  = quot b a : xs
evalToken l s = maybe l (\x -> x : l) (convertToInt s)

eval :: [String] -> Int
eval l = head (foldl evalToken [] l)

main :: IO ()
main = do
    line <- getLine
    if line == "#"
        then return ()
        else do
            putStrLn $ show (eval (words line))
            main