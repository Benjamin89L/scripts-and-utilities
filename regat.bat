@set RegistryKey=%*

@set RegistryKey=%RegistryKey:HKCU=HKEY_CURRENT_USER%
@set RegistryKey=%RegistryKey:HKLM=HKEY_LOCAL_MACHINE%

@reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Applets\Regedit /v LastKey /t REG_SZ /d "%RegistryKey%" /f

@start regedit
