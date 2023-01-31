def max(*a):
    num = 0
    for n in a:
        if (n > num):
            num = n
    return num


print(max(10, 20, 11, 21, 50, 40, 100, 30))
