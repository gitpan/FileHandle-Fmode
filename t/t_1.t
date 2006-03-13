use strict;
use FileHandle::Fmode qw(:all);
use File::Spec;

print "1..28\n";

my ($rd, $wr, $rw, $invalid, $one, $undef);

open(RD, "Makefile.PL") or die "Can't open makefile.PL for reading: $!";
open($rd, "Fmode.pm") or die "Can't open Fmode.pm for reading: $!";

if(is_R(\*RD)) {print "ok 1\n"}
else {print "not ok 1\n"}

if(is_R($rd)) {print "ok 2\n"}
else {print "not ok 2\n"}

if(is_RO(\*RD)) {print "ok 3\n"}
else {print "not ok 3\n"}

if(is_RO($rd)) {print "ok 4\n"}
else {print "not ok 4\n"}

#####################################################

open(WR, ">temp.txt") or die "Can't open temp.txt for writing: $!";
open($wr, ">temp2.txt") or die "Can't open temp2.txt for writing: $!";

if(is_W(\*WR)) {print "ok 5\n"}
else {print "not ok 5\n"}

if(is_W($wr)) {print "ok 6\n"}
else {print "not ok 6\n"}

if(is_WO(\*WR)) {print "ok 7\n"}
else {print "not ok 7\n"}

if(is_WO($wr)) {print "ok 8\n"}
else {print "not ok 8\n"}

#####################################################

close(RD) or die "Can't close Makefile.PL after opening for reading: $!";
close($rd) or die "Can't close Fmode.pm after opening for reading: $!";
close(WR) or die "Can't close temp.txt after opening for writing: $!";
close($wr) or die "Can't close temp2.txt after opening for writing: $!";

open(RW, ">>temp.txt") or die "Can't open temp.txt for writing: $!";
open($rw, ">>temp2.txt") or die "Can't open temp2.txt for writing: $!";

if(is_W(\*RW)) {print "ok 9\n"}
else {print "not ok 9\n"}

if(is_W($rw)) {print "ok 10\n"}
else {print "not ok 10\n"}

if(is_WO(\*RW)) {print "ok 11\n"}
else {print "not ok 11\n"}

if(is_WO($rw)) {print "ok 12\n"}
else {print "not ok 12\n"}

close(RW) or die "Can't close temp.txt after opening for appending: $!";
close($rw) or die "Can't close temp2.txt after opening for appending: $!";

#####################################################

open(RW, "+>temp.txt") or die "Can't open temp.txt for reading/writing: $!";
open($rw, "+>temp2.txt") or die "Can't open temp2.txt for reading/writing: $!";

if(is_RW(\*RW)) {print "ok 13\n"}
else {print "not ok 13\n"}

if(is_RW($rw)) {print "ok 14\n"}
else {print "not ok 14\n"}

if(is_R(\*RW) && !is_RO(\*RW)) {print "ok 15\n"}
else {print "not ok 15\n"}

if(is_W($rw) && !is_WO($rw)) {print "ok 16\n"}
else {print "not ok 16\n"}

close(RW) or die "Can't close temp.txt after opening for reading/writing: $!";
close($rw) or die "Can't close temp2.txt after opening for reading/writing: $!";

#####################################################

open(RW, "+<temp.txt") or die "Can't open temp.txt for reading/writing: $!";
open($rw, "+<temp2.txt") or die "Can't open temp2.txt for reading/writing: $!";

if(is_RW(\*RW)) {print "ok 17\n"}
else {print "not ok 17\n"}

if(is_RW($rw)) {print "ok 18\n"}
else {print "not ok 18\n"}

if(is_R(\*RW) && !is_RO(\*RW)) {print "ok 19\n"}
else {print "not ok 19\n"}

if(is_W($rw) && !is_WO($rw)) {print "ok 20\n"}
else {print "not ok 20\n"}

close(RW) or die "Can't close temp.txt after opening for reading/writing: $!";
close($rw) or die "Can't close temp2.txt after opening for reading/writing: $!";

#####################################################

open(RW, "+>>temp.txt") or die "Can't open temp.txt for reading/writing: $!";
open($rw, "+>>temp2.txt") or die "Can't open temp2.txt for reading/writing: $!";

if(is_RW(\*RW)) {print "ok 21\n"}
else {print "not ok 21\n"}

if(is_RW($rw)) {print "ok 22\n"}
else {print "not ok 22\n"}

if(is_R(\*RW) && !is_RO(\*RW)) {print "ok 23\n"}
else {print "not ok 23\n"}

if(is_W($rw) && !is_WO($rw)) {print "ok 24\n"}
else {print "not ok 24\n"}

close(RW) or die "Can't close temp.txt after opening for reading/writing: $!";
close($rw) or die "Can't close temp2.txt after opening for reading/writing: $!";

open($invalid, "non_existent.txt");
open(INV, "non_existent_file.txt");

# Hide the warnings that the following tests generate.
my $null = File::Spec->devnull;
open(STDERR, ">$null"); 

if(is_R($invalid) || is_W($invalid) || is_RO($invalid) || is_WO($invalid) || is_RW($invalid)) {print "not ok 25\n"}
else {print "ok 25\n"}

if(is_R(\*INV) || is_W(\*INV) || is_RO(\*INV) || is_WO(\*INV) || is_RW(\*INV)) {print "not ok 26\n"}
else {print "ok 26\n"}

$one = 1;

if(is_R($one) || is_W($one) || is_RO($one) || is_WO($one) || is_RW($one)) {print "not ok 27\n"}
else {print "ok 27\n"}

eval {if(is_R($undef)){};}; 
if($@){print "ok 28\n"}
else {print "not ok 28\n"}

