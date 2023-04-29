# Yabai 指令操作指引

## 查詢 N 桌面裡有那幾個「視窗」

```python
yabai -m query --windows --space 5
```

```sh
yabai -m query --windows --space 5
 yabai -m query --windows --space 5 | jq '.[] | {id: .id, app: .app, title: .title}'

{
  "id": 220,
  "app": "Google Chrome",
  "title": "Hammerspoon Lua Script - Google Chrome - 正中"
}
{
  "id": 175,
  "app": "iTerm2",
  "title": "MacBook-Pro ❐ iTerm ● 9 WM"
}
```
