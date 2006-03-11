package FileHandle::Fmode;
use warnings;
use Fcntl;
use strict;

require Exporter;
require DynaLoader;

our $VERSION = 0.01;

our @ISA = qw(Exporter DynaLoader);

our @EXPORT_OK = qw(is_R is_W is_RO is_WO is_RW);

our %EXPORT_TAGS = (all => [qw
    (is_R is_W is_RO is_WO is_RW)]);

if($^O =~ /mswin32/i) {
  bootstrap FileHandle::Fmode $VERSION;

  *is_R  = \&win32_readable;
  *is_W  = \&win32_writable;
  *is_RO = \&win32_readable_only;
  *is_WO = \&win32_writable_only;
  *is_RW = \&win32_readable_writable;
  }

else {
  *is_R  = \&unix_readable;
  *is_W  = \&unix_writable;
  *is_RO = \&unix_readable_only;
  *is_WO = \&unix_writable_only;
  *is_RW = \&unix_readable_writable;
  }

sub unix_readable_only {
    my $fmode = fcntl($_[0], F_GETFL, my $slush = 0);
    if($fmode && $fmode == 0) {return 1}
    return 0;
    }

sub unix_writable_only {
    my $fmode = fcntl($_[0], F_GETFL, my $slush = 0);
    if($fmode & 1) {return 1}
    return 0;
}

sub unix_writable {
    my $fmode = fcntl($_[0], F_GETFL, my $slush = 0);
    if($fmode & 1 || $fmode & 2) {return 1}
    return 0;
}

sub unix_readable {
    my $fmode = fcntl($_[0], F_GETFL, my $slush = 0);
    if($fmode && ($fmode == 0 || $fmode & 2)) {return 1}
    return 0;
    }

sub unix_readable_writable {
    my $fmode = fcntl($_[0], F_GETFL, my $slush = 0);
    if($fmode & 2) {return 1}
    return 0;
    }

sub win32_readable_only {
    if(win32_fmode($_[0]) & 1) {return 1}
    return 0;
    }

sub win32_writable_only {
    if(win32_fmode($_[0]) & 2) {return 1}
    return 0;
}

sub win32_writable {
    my $fmode = win32_fmode($_[0]);
    if($fmode & 2 || $fmode & 128) {return 1}
    return 0;
}

sub win32_readable {
    my $fmode = win32_fmode($_[0]);
    if($fmode & 1 || $fmode & 128) {return 1}
    return 0;
    }

sub win32_readable_writable {
    if(win32_fmode($_[0]) & 128) {return 1}
    return 0;
    }

1;

__END__

=head1 NAME


FileHandle::Fmode - determine whether a filehandle is opened for reading, writing, or both.

=head1 SYNOPSIS


 use FileHandle::Fmode qw(:all);
 .
 .
 #$fh and FH are open filehandles
 print is_R($fh), "\n";
 print is_W(\*FH), "\n";

=head1 FUNCTIONS


 $bool = is_R($fh);
 $bool = is_R(\*FH);
  Returns true if the filehandle is readable.
  Else returns false.

 $bool = is_W($fh);
 $bool = is_W(\*FH);
  Returns true if the filehandle is writable.
  Else returns false

 $bool = is_RO($fh);
 $bool = is_RO(\*FH);
  Returns true if the filehandle is readable but not writable.
  Else returns false

 $bool = is_WO($fh);
 $bool = is_WO(\*FH);
  Returns true if the filehandle is writable but not readable.
  Else returns false

 $bool = is_RW($fh);
 $bool = is_RW(\*FH);
  Returns true if the filehandle is both readable and writable.
  Else returns false

=head1 CREDITS


 Inspired (hmmm ... is that the right word ?) by an idea from BrowserUK
 posted on PerlMonks in response to a question from dragonchild. Win32
 XS code provided by BrowserUK. Not sure who gets the credit for the
 Fcntl macro ... certainly not me.

=head1 LICENSE


 This program is free software; you may redistribute it and/or 
 modify it under the same terms as Perl itself.

=head1 AUTHOR


 Sisyphus <kalinabears at iinet dot net dot au>

=cut
