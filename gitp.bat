@rem
@rem  Ask for the Password if it
@rem  is not already set:
@rem


@call set tq84_cd=%cd%\
@call set tq84_cd=%%tq84_cd:%git_work_dir%=%%

@if "%tq84_cd%"=="%cd%\" (
  @rem @echo gitp.bat: I am not under %git_work_dir%

  @if [%TQ84_GITHUB_PW%] EQU [] (
    @set /p TQ84_GITHUB_PW=TQ84_GITHUB_PW? 
  )

) else (
  @rem @echo gitp.bat: I am under %git_work_dir%
)

@git-push.pl
