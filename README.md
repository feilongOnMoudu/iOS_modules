# 创建一个能够独立依赖的Framework工程

参考链接：
[iOS从静态库加载Storyboard并创建View](https://www.jianshu.com/p/f2ffe8325519)


## 1、准备工作

```
1、new Framework to xcworkspace menu
```

```
2、File -> new -> targets -> Single View App
```

```
3、Single View App -> Project 选中创建的Framework ->Finish
```

## 2、修改步骤 (Framework篇)

```
1、修改新建的target工程的AppDelegate名字
```

```
2、选中Framework -> Build Phases -> Copy Bundle Res ->加入故事版文件，
```

```
3、选中Framework -> Build Phases -> Compile Sources  ->加入所有的.m文件，
```

```
4、选中Framework -> Build Phases -> + -> new headers Phase ->加入项目中所有用到的.h文件，并在Framework唯一的头文件中#import <LoginFramework/PublicHeader.h>
```

```
5、选中Framework -> Build Settings ->Other Linker Flags -> -Objc，User Header Search Paths -> $(BUILT_PRODUCTS_DIR)(recrusive)
```

```
6、选中Framework -> Build Phases -> Target Dependencies -> Add -> target
```

## 3、修改步骤 (主工程篇)

```
1、选中主工程targets -> General -> Embedded Binaries -> add Framework,这时候Linked中也会出现Framework，Build Phases -> Link Binary With Libraries也会出现这个Framework
```

```
2、选中主工程targets -> Build Phases -> Copy Bundle Res -> add Framework
```

```
3、选中主工程targets -> Build Setting -> User Serach Paths -> add $(BUILT_PRODUCTS_DIR) (recursive)
```


## 4、注意点
- 框架工程的.h文件 头导入格式：
例如 ：LoginVC.h  那么.m中应为 #import <LoginFramework/LoginVC.h> （尤为注意）

- UnKnow Type name  重复导入

## 5、问题

```
Class ASIAuthenticationDialog is implemented in both ·······
One of the two will be used. Which one is undefined.
解决方法:查找对应的class是不是在两个工程中都存在，需重命名
原因：objc runtime对所用app使用同一个命名空间(flat namespace)，运行机制
1、首先二进制映像被加载，检查程序依赖关系
2、每一个二进制映像被加载的同时，程序的objc classes在objc runtime命名空间中注册
3、如果具有相同名称的类被再次加载，objc runtime的行为是不可预知的。一种可能的情况是任意一个程序的该类会被加载(这应该也是默认动作)
```


```
Archive时Archives列表里面只有Other Items的问题
定位原因: Organizer -> Other Items -> 选中该工程 -> Show in Finder -> 显示包内容 -> Products -> 单独一个Applications是正确的 多出来的文件夹是错误的 ->  查看文件夹名称
解决方法：target -> Build Phases -> Headers中所有Pubilcs中的文件移到Project
```










