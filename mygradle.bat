::chcp 65001
@echo off

setlocal enabledelayedexpansion

set filename=\gradle.properties
::文件是否有该字段
set proxyKey=proxyHost
::代理服务器字符串
set proxyHost=systemProp.https.proxyHost=127.0.0.1
set proxyPort=systemProp.https.proxyPort=10809
::set file_path=%WORKSPACE%%filename%

set file_path=C:\ProgramData\Jenkins\.jenkins\workspace\yingwen\gradle.properties

if exist !file_path! (
        ::读取文件内容
       set file_content=
       for /f "eol=# delims=" %%j in (!file_path!) do (
           set file_content=!file_content!%%j
       )
       echo File content: !file_content!

      ::查找是否设置了代理
      echo !file_content! | findstr "!proxyKey!" >nul
      if !errorlevel! equ 0 (
        echo have set proxy server!
      ) else (
        ::在文件插入代理设置字符
        echo set proxy server.....
        ::echo:是换行
        echo:>>!file_path!
        echo %proxyHost%>>!file_path!
        echo %proxyPort%>>!file_path!
      )
    ) else (
      echo  workespace no hava gradle.properties
    )

endlocal
::脚步执行完，设置结果为0
exit 0


