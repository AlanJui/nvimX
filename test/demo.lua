local function fact(n)
    if n == 0 then
        return 1
    else
        return n * fact(n - 1)
    end
end

print('Enter a number:')
local num = io.read('*number')
print(fact(num))
