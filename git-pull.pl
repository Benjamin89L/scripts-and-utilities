#!/usr/bin/perl
use warnings;
use strict;
use Cwd;

my $verbose = 0;

my $cwd = cwd() . '/';
my $gwd = $ENV{git_work_dir};

if ($^O eq 'MSWin32') {
  $cwd =~ s!\\!/!g;
  $gwd =~ s!\\!/!g;
  
  $cwd =~ s!^(.):!lc($1) . ':'!ex;
  $gwd =~ s!^(.):!lc($1) . ':'!ex;
}

print "cwd: $cwd\n" if $verbose;
print "gwd: $gwd\n" if $verbose;

if ( # { Pull from github (TODO Same as in git-push.pl)
     #     We have to determine if we have to pull from github.
     #     This is (probably) the case if one of the following three conditions
     #     hold true:
     #
     ! defined $gwd or                          # - gwd not defined: most probably we're not in git localgit directory.
      (length($cwd) <  length($gwd) or          # - cur work directory is not within working directory.
       substr($cwd, 0, length($gwd)) ne $gwd)   # - The current working directory path starts differently from the git work dir.
    ) {
  print "pull from github\n" if $verbose;
  print (readpipe('git pull')); 
} # }
else { # { pull from harddisk
  die "Environment variable git_work_dir not defined" unless ($gwd);
  my $cmd;
  print "pull from harddisk\n" if $verbose;
  if ($^O eq 'linux') {
    $cmd = "git pull '$ENV{git_local_repo_dir}'";
  }
  else {
    $cmd = "git pull $ENV{git_local_repo_dir}"; 
  }
  print "$cmd\n" if $verbose;
  print (readpipe($cmd)); 
} # }
