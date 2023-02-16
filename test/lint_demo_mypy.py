def example(n: int) -> str:
    print(type(n))
    return 'hello'

# 以下程式碼，若將 ＃type: ignore 移除，會出現出
# 自 pyright 與 mypy 發出的錯誤警示訊息。
example('a') # type: ignore
