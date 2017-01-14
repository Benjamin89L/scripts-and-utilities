#!/usr/bin/perl

#
#   In Windows (cmd.exe), the script gitp.bat
#   should be used. This bat file asks for
#   the password of TQ84_GITHUB_PW if it
#   is not already set.
#

use warnings;
use strict;
use Cwd;

my $verbose = 0;

my $cwd = cwd() . '/';
my $gwd = $ENV{git_work_dir};

$cwd =~ s!\\!/!g;
$gwd =~ s!\\!/!g;

print "$0
  cwd=$cwd
  gwd=$gwd
" if $verbose;

if (length($cwd) < length($gwd) or substr($cwd, 0, length($gwd)) ne $gwd) { # { Push to github

  print "  Not within $ENV{git_work_dir}\n" if $verbose;

  my $remote = readpipe("git config --get remote.origin.url");
  
  my $renes_password=$ENV{TQ84_GITHUB_PW};
  
  die "Set TQ84_GITHUB_PW" unless $renes_password;
  
  $remote =~ s,https://,https://ReneNyffenegger:$renes_password\@,;
  
  print readpipe ("git push $remote");

} # }
else { # { Push to harddisk

  print "  Within $ENV{git_work_dir}\n" if $verbose;
  if ($^O eq 'linux') {
    print readpipe ("git push '$ENV{git_local_repo_dir}'");
  }
  else {
    print readpipe ("git push $ENV{git_local_repo_dir}");
  }
} # }
