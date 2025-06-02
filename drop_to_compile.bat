::Dependent on folder Compiler to be present in the same directory. Compiler contains Ahk2Exe.exe and other relevant files from 
::		->Compiler\Ahk2Exe.exe
::functionality
::This .bat just helps to recompile an ahk-script fast, so you can skip the process of exit old task, compile with ahk2exe GUI (and restart new .exe).
::
::
::How to:
::Just drag and drop your .ahk-file on this bat to compile the .exe-file.
::
::https://github.com/torobidum
::
SET batPath=%~dp0
For %%A in ("%1") do (
    Set Folder=%%~dpA
    Set Name=%%~nxA
)
::kill old instance if one exits
taskkill /IM %Name%.exe
::delete old .exe file
del "%1.exe"
::Compiler\Ahk2Exe.exe /in %batPath%%1.ahk /out %batPath%%1.exe 
Compiler\Ahk2Exe.exe /in %1 /out %1.exe 
echo "%1 compiled and started"
::start new instance of ahk-script

::optional: start new .exe
::%1.exe




