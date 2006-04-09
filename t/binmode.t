use strict;
use FileHandle::Fmode qw(:all);

# Same tests as basic.t - except here we binmode() the handles to check
# that makes no difference ... no reason that it should, of course ...

print "1..43\n";

my ($rd, $wr, $rw, $one, $undef, $null, $mem, $var);

open(RD, "Makefile.PL") or die "Can't open makefile.PL for reading: $!";
open($rd, "Fmode.pm") or die "Can't open Fmode.pm for reading: $!";

binmode(RD);
binmode($rd);

if(is_arg_ok(\*RD) && is_R(\*RD) && is_RO(\*RD) && !is_W(\*RD) && !is_WO(\*RD) && !is_RW(\*RD)) {print "ok 1\n"}
else {print "not ok 1\n"}

if(is_arg_ok($rd) && is_R($rd) && is_RO($rd) && !is_W($rd) && !is_WO($rd) && !is_RW($rd)) {print "ok 2\n"}
else {print "not ok 2\n"}

close(RD) or die "Can't close Makefile.PL after opening for reading: $!";
close($rd) or die "Can't close Fmode.pm after opening for reading: $!";

open(RD, "<Makefile.PL") or die "Can't open makefile.PL for reading: $!";
open($rd, "<Fmode.pm") or die "Can't open Fmode.pm for reading: $!";

binmode(RD);
binmode($rd);

if(is_arg_ok(\*RD) && is_R(\*RD) && is_RO(\*RD) && !is_W(\*RD) && !is_WO(\*RD) && !is_RW(\*RD)) {print "ok 3\n"}
else {print "not ok 3\n"}

if(is_arg_ok($rd) && is_R($rd) && is_RO($rd) && !is_W($rd) && !is_WO($rd) && !is_RW($rd)) {print "ok 4\n"}
else {print "not ok 4\n"}

close(RD) or die "Can't close Makefile.PL after opening for reading: $!";
close($rd) or die "Can't close Fmode.pm after opening for reading: $!";

#####################################################

open(WR, ">temp.txt") or die "Can't open temp.txt for writing: $!";
open($wr, ">temp2.txt") or die "Can't open temp2.txt for writing: $!";

binmode(WR);
binmode($wr);

if(is_arg_ok(\*WR) && is_W(\*WR) && is_WO(\*WR)) {print "ok 5\n"}
else {print "not ok 5\n"}

if(is_arg_ok($wr) && is_W($wr) && is_WO($wr)) {print "ok 6\n"}
else {print "not ok 6\n"}

if(!is_RO(\*WR) && !is_R(\*WR) && !is_RW(\*WR)) {print "ok 7\n"}
else {print "not ok 7\n"}

if(!is_RO($wr) && !is_R($wr) && !is_RW($wr)) {print "ok 8\n"}
else {print "not ok 8\n"}

#####################################################

close(WR) or die "Can't close temp.txt after opening for writing: $!";
close($wr) or die "Can't close temp2.txt after opening for writing: $!";

open(WR, ">>temp.txt") or die "Can't open temp.txt for writing: $!";
open($wr, ">>temp2.txt") or die "Can't open temp2.txt for writing: $!";

binmode(WR);
binmode($wr);

if(is_arg_ok(\*WR) && is_W(\*WR) && is_WO(\*WR)) {print "ok 9\n"}
else {print "not ok 9\n"}

if(is_arg_ok($wr) && is_W($wr) && is_WO($wr)) {print "ok 10\n"}
else {print "not ok 10\n"}

if(!is_RO(\*WR) && !is_R(\*WR) && !is_RW(\*WR)) {print "ok 11\n"}
else {print "not ok 11\n"}

if(!is_RO($wr) && !is_R($wr) && !is_RW($wr)) {print "ok 12\n"}
else {print "not ok 12\n"}

close(WR) or die "Can't close temp.txt after opening for appending: $!";
close($wr) or die "Can't close temp2.txt after opening for appending: $!";

#####################################################

open(RW, "+>temp.txt") or die "Can't open temp.txt for reading/writing: $!";
open($rw, "+>temp2.txt") or die "Can't open temp2.txt for reading/writing: $!";

binmode(RW);
binmode($rw);

if(is_arg_ok(\*RW) && is_RW(\*RW) && is_W(\*RW) && is_R(\*RW)) {print "ok 13\n"}
else {print "not ok 13\n"}

if(is_arg_ok($rw) && is_RW($rw) && is_W($rw) && is_R($rw)) {print "ok 14\n"}
else {print "not ok 14\n"}

if(!is_RO(\*RW) && !is_WO(\*RW)) {print "ok 15\n"}
else {print "not ok 15\n"}

if(!is_RO($rw) && !is_WO($rw)) {print "ok 16\n"}
else {print "not ok 16\n"}

close(RW) or die "Can't close temp.txt after opening for reading/writing: $!";
close($rw) or die "Can't close temp2.txt after opening for reading/writing: $!";

#####################################################

open(RW, "+<temp.txt") or die "Can't open temp.txt for reading/writing: $!";
open($rw, "+<temp2.txt") or die "Can't open temp2.txt for reading/writing: $!";

binmode(RW);
binmode($rw);

if(is_arg_ok(\*RW) && is_RW(\*RW) && is_W(\*RW) && is_R(\*RW)) {print "ok 17\n"}
else {print "not ok 17\n"}

if(is_arg_ok($rw) && is_RW($rw) && is_W($rw) && is_R($rw)) {print "ok 18\n"}
else {print "not ok 18\n"}

if(!is_RO(\*RW) && !is_WO(\*RW)) {print "ok 19\n"}
else {print "not ok 19\n"}

if(!is_RO($rw) && !is_WO($rw)) {print "ok 20\n"}
else {print "not ok 20\n"}

close(RW) or die "Can't close temp.txt after opening for reading/writing: $!";
close($rw) or die "Can't close temp2.txt after opening for reading/writing: $!";

#####################################################

open(RW, "+>>temp.txt") or die "Can't open temp.txt for reading/writing: $!";
open($rw, "+>>temp2.txt") or die "Can't open temp2.txt for reading/writing: $!";

binmode(RW);
binmode($rw);

if(is_arg_ok(\*RW) && is_RW(\*RW) && is_W(\*RW) && is_R(\*RW)) {print "ok 21\n"}
else {print "not ok 21\n"}

if(is_arg_ok($rw) && is_RW($rw) && is_W($rw) && is_R($rw)) {print "ok 22\n"}
else {print "not ok 22\n"}

if(!is_RO(\*RW) && !is_WO(\*RW)){print "ok 23\n"}
else {print "not ok 23\n"}

if(!is_RO($rw) && !is_WO($rw)) {print "ok 24\n"}
else {print "not ok 24\n"}

close(RW) or die "Can't close temp.txt after opening for reading/writing: $!";
close($rw) or die "Can't close temp2.txt after opening for reading/writing: $!";

eval {is_R($undef)}; 
if($@ && !is_arg_ok($undef)){print "ok 25\n"}
else {print "not ok 25\n"}

eval {is_RO($undef)}; 
if($@){print "ok 26\n"}
else {print "not ok 26\n"}

eval {is_W($undef)}; 
if($@){print "ok 27\n"}
else {print "not ok 27\n"}

eval {is_WO($undef)}; 
if($@){print "ok 28\n"}
else {print "not ok 28\n"}

eval {is_RW($undef)}; 
if($@){print "ok 29\n"}
else {print "not ok 29\n"}

$one = 1;

eval {is_R($one)}; 
if($@ && !is_arg_ok($one)){print "ok 30\n"}
else {print "not ok 30\n"}

eval {is_RO($one)}; 
if($@){print "ok 31\n"}
else {print "not ok 31\n"}

eval {is_W($one)}; 
if($@){print "ok 32\n"}
else {print "not ok 32\n"}

eval {is_WO($one)}; 
if($@){print "ok 33\n"}
else {print "not ok 33\n"}

eval {is_RW($one)}; 
if($@){print "ok 34\n"}
else {print "not ok 34\n"}

if($] >= 5.007) {

  $var = ''; # Avoid "uninitialised" warnings.

  open($mem, '<', \$var) or die "Can't open memory object: $!";
  binmode($mem);
  if(is_arg_ok($mem) && is_R($mem) && is_RO($mem) && !is_W($mem) && !is_WO($mem) && !is_RW($mem)) {print "ok 35\n"}
  else {print "not ok 35\n"}
  close($mem) or die "Can't close memory object: $!";

  open($mem, '>', \$var) or die "Can't open memory object: $!";
  binmode($mem);
  if(is_arg_ok($mem) && !is_R($mem) && !is_RO($mem) && is_W($mem) && is_WO($mem) && !is_RW($mem)) {print "ok 36\n"}
  else {print "not ok 36\n"}
  close($mem) or die "Can't close memory object: $!";

  open($mem, '>>', \$var) or die "Can't open memory object: $!";
  binmode($mem);
  if(is_arg_ok($mem) && !is_R($mem) && !is_RO($mem) && is_W($mem) && is_WO($mem) && !is_RW($mem)) {print "ok 37\n"}
  else {print "not ok 37\n"}
  close($mem) or die "Can't close memory object: $!";

  open($mem, '+>>', \$var) or die "Can't open memory object: $!";
  binmode($mem);
  if(is_arg_ok($mem) && is_R($mem) && !is_RO($mem) && is_W($mem) && !is_WO($mem) && is_RW($mem)) {print "ok 38\n"}
  else {print "not ok 38\n"}
  close($mem) or die "Can't close memory object: $!";


  open($mem, '+>', \$var) or die "Can't open memory object: $!";
  binmode($mem);
  if(is_arg_ok($mem) && is_R($mem) && !is_RO($mem) && is_W($mem) && !is_WO($mem) && is_RW($mem)) {print "ok 39\n"}
  else {print "not ok 39\n"}
  close($mem) or die "Can't close memory object: $!";

  open($mem, '+<', \$var) or die "Can't open memory object: $!";
  binmode($mem);
  if(is_arg_ok($mem) && is_R($mem) && !is_RO($mem) && is_W($mem) && !is_WO($mem) && is_RW($mem)) {print "ok 40\n"}
  else {print "not ok 40\n"}
  close($mem) or die "Can't close memory object: $!";

}
else {
  print "ok 35 - skipped - old perl\n";
  print "ok 36 - skipped - old perl\n";
  print "ok 37 - skipped - old perl\n";
  print "ok 38 - skipped - old perl\n";
  print "ok 39 - skipped - old perl\n";
  print "ok 40 - skipped - old perl\n";
}

open($rd, "Makefile.PL") or die "Can't open Makefile.PL for reading: $!";
binmode($rd);
eval{FileHandle::Fmode::perliol_readable($rd);};

if($] < 5.007) {
  if($@ =~ /perliol_readable/) {print "ok 41\n"}
  else {print "not ok 41\n"} 
}
else {
  if($@) {print "not ok 41\n"}
  else {print "ok 41\n"}
}

close($rd) or die "Can't close Makefile.PL after opening for reading: $!";

open($wr, ">temp2.txt") or die "Can't open temp2.txt for writing: $!";
binmode($wr);
eval{FileHandle::Fmode::perliol_writable($wr);};

if($] < 5.007) {
  if($@ =~ /perliol_writable/) {print "ok 42\n"}
  else {print "not ok 42\n"} 
}
else {
  if($@) {print "not ok 42\n"}
  else {print "ok 42\n"}
}

eval{FileHandle::Fmode::win32_fmode($wr);};
if($^O =~ /mswin32/i) {
  if($@) {print "not ok 43\n"}
  else {print "ok 43\n"}
}
else {
  if($@ =~ /win32_fmode/) {print "ok 43\n"}
  else {print "not ok 43\n"}
}

close($wr) or die "Can't close temp2.txt after opening for writing: $!";

