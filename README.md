# date-compare
a shell script to list files to different texts judged by date line

## 用法
```
./date-compare.sh DATELIMIT [<FILE]
```
## 实例
### 1.带 `<FILE` 参数
```
./date-compare.sh 20151109 <files.txt
```
files.txt文件中的内容是一行行的具体文件的路径。例如：/data/a/b/c/x.txt
### 2.不带 `<FILE` 参数
```
./date-compare.sh 20151109
```
然后从键盘输入具体的文件路径，比如：
```
/data/a/b/c/x.txt
/data/a/b/c/y.txt
(ctrl+D结束输入)
```
