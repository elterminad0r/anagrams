import System.Environment

set_item :: [a] -> Int -> a -> [a]
set_item (x:xs) 0 y = y:xs
set_item (x:xs) n y = x:set_item xs (n - 1) y

min_of_two :: (Ord a) => a -> a -> a
min_of_two x y | x < y = x | otherwise = y

min_item :: (Ord a) => [a] -> (a, Int)
min_item [a] = (a, 0)
min_item (x:xs) = let (alt, ind) = min_item xs in
                        min_of_two (x, 0) (alt, ind + 1)

sel_sort :: (Ord a) => [a] -> [a]
sel_sort [] = []
sel_sort [a] = [a]
sel_sort xs = let (min_it, pos) = min_item xs in
                        min_it:(sel_sort . tail . (set_item xs pos) . head) xs

is_anagram :: (Ord a) => [a] -> [a] -> Bool
is_anagram x y = (sel_sort x) ==  (sel_sort y)

main = do
    [a, b] <- getArgs
    print $ is_anagram a b
