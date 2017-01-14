#
#  ${git_work_dir%/}
#      This expression removes the trailing slash in $git_work_dir
#
#  ${PWD##${git_work_dir%/}}
#       This expression removes $git_work_dir (without trailing slash)
#       from the beginning of $PWD
#
#       If this expression != PWD, we could remove $git_work_dir from
#       $PWD, so we are in or below $git_work_dir
#
if [[ ${PWD##${git_work_dir%/}} != ${PWD} ]]; then
 : #  echo "not asking for TQ84_GITHUB_PW"
else

  if [ -z ${TQ84_GITHUB_PW+x} ]; then
    echo -n "TQ84_GITHUB_PW: "
    read TQ84_GITHUB_PW
    export TQ84_GITHUB_PW
  fi

fi

git-push.pl
