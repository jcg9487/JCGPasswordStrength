# PasswordStrength

![](https://img.shields.io/badge/language-Objective--C-green) ![](https://img.shields.io/badge/support-iOS9%2B-red) ![](https://img.shields.io/cocoapods/l/PasswordStrength?color=green)

密码强度算法，[参考文章](https://blog.csdn.net/u010156024/article/details/45673581)

基于密码得分来判断密码的强度，根据实际业务进行分数段的取舍。

```objective-c
NSInteger score =  [[PasswordStrengthUtil sharedInstance] passwordStrengthWith:currentText];
```

具体的密码强度判断，可以自定义分数范围来确定。

> 例如
>
> score  < 60 弱
>
> score  < 80 中
>
> score  >= 80 强

![](./img/example.gif)

