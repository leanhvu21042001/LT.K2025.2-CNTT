---
created: 2026-01-08T13:20:00
updated:
type:
id:
title: "Thực hành 1: Viết chương trình C trên Google Colab"
subject: Operating Systems
tags:
  - 
provider: UIT
---
# Google Colab

- Shell
    - `!<command>`
- Magic shell
    - `%%<command>`

```bash
%%writefile <filename>
```

Ex:

```c
%%writefile hello.cpp
#include<stdio.h>

int main()
{
    print("Hello World.\n");
    return 0;
}
```
