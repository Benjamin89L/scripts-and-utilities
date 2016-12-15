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

if ( cwd() . '/' =~ m!^$ENV{git_work_dir}!) {

  print "Within $ENV{git_work_dir}\n";
  print readpipe ('git push /media/rene/TOSHIBA\ EXT/git');

}
else {

  print "Not within $ENV{git_work_dir}\n";
  my $remote = readpipe("git config --get remote.origin.url");
  
  my $renes_password=$ENV{TQ84_GITHUB_PW};
  
  die "Set TQ84_GITHUB_PW" unless $renes_password;
  
  $remote =~ s,https://,https://ReneNyffenegger:$renes_password\@,;
  
  print readpipe ("git push $remote");
}
