eval '(exit $?0)' && eval 'exec perl -S $0 ${1+"$@"}' && eval 'exec perl -S $0 $argv:q'
  if 0;
use strict;
$^W=1; # turn warning on
#
# ziptimetree.pl
#
# Packs a directory tree into a ZIP file with sorted entries
# and corrects file permissions and directory dates.
#
# Copyright 2006, 2011 Heiko Oberdiek.
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this library; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
# MA  02110-1301  USA
#
# Address: heiko.oberdiek at googlemail.com
#
my $file        = 'ziptimetree';
my $program     = 'ZIP-TimeTree';
my $version     = '1.3';
my $date        = '2011/04/15';
my $author      = 'Heiko Oberdiek';
my $copyright   = "Copyright (C) 2006, 2011 by $author.";
#
# History:
#   2006/06/04 v1.0: First release.
#   2006/06/07 v1.1: License LGPL.
#   2006/06/15 v1.2: Small correction in option code.
#   2011/04/15 v1.3: Email address updated.

### program identification
my $title = "$program $version, $date - $copyright\n";

### error strings
my $error = "!!! Error:"; # error prefix
my $warning = "!!! Warning:";

### file modes (type and permission)
my $mode_directory    =  040755; # drwxr-xr-x
my $mode_file_regular = 0100644; # -rw-r--r--
my $mode_file_exec    = 0100755; # -rwxr-xr-x

### programs
my $prg_zip = 'zip';
my $prg_pwd = 'pwd';

### file extensions
my $ext_zip = '.zip';

### counters
my $count_dir = 0;
my $count_file = 0;
my $count_exclude = 0;
my $count_mode = 0;
my $count_time = 0;
my $count_warn = 0;

### log levels
my $log_quiet   = 0;
my $log_normal  = 1;
my $log_verbose = 2;
my $log_debug   = 3;

### option variables
my $help        = 0;
my $log_level   = 1;
my $compression = 9;
my $root        = 1;
my $update      = 0;
my @exclude;
my $tree;
my $zipfile;

my $usage = <<"END_OF_USAGE";
${title}
Syntax: $file [options] <zipfile> <treedir>

  <zipfile>  The file where the result is stored as zipped file.
             The name must end in '.zip'.
  <treedir>  Specifies the root of a directory tree whose
             directories and files are packed into the <zipfile>.

Functions:
* The permissions in the directory tree are normalized:
    drwxr-xr-x   directories
    -rwxr-xr-x   executable files
    -rw-r--r--   regular files
* The time stamps of the directories are set to the time of the
  latest file somewhere below that directory.
* The zip file is created with the same time as the latest file
  inside the archive.
* Also the entries are orderd by depth-first and name:
  * The directory tree is traversed in deep-first order.
  * If a directory is reached, first its directory entries are
    processed in alphabetical order. Then its files are added,
    sorted by names.

Options:                                                         defaults:
  --help               print usage
  --quiet              quiet except for warnings and errors
  --verbose            verbose output
  --debug              debug output
  -0 .. -9             store only .. best compression            (-9)
  --(no)update         zip file is not deleted before creating   (--noupdate)
  --(no)root           use/strip root directory name             (--root)
  --exclude <pattern>  exclude files by regular expression

File exclusion:
  Option --exclude allows you to specify pattern that are
  used to exclude files from packing into the zipfile.
  The option can be invoked several times, the pattern are
  collected in a list.
    During the tree traversal the name of files and directories
  are generated. Depending on the state of option --root these
  names may or may not include the root directory name.
  In order to distinguish between files and directories, a slash
  is appended to a directory name. Then the patterns are used
  as regular expressions. Files or directories which names matches
  are excluded, in case of directories the whole tree.

END_OF_USAGE

### process options
use Getopt::Long;
GetOptions(
    '0'         => sub { $compression = 0 },
    '1'         => sub { $compression = 1 },
    '2'         => sub { $compression = 2 },
    '3'         => sub { $compression = 3 },
    '4'         => sub { $compression = 4 },
    '5'         => sub { $compression = 5 },
    '6'         => sub { $compression = 6 },
    '7'         => sub { $compression = 7 },
    '8'         => sub { $compression = 8 },
    '9'         => sub { $compression = 9 },
    'help!'     => sub { die $usage },
    'quiet'     => sub { $log_level = $log_quiet },
    'verbose'   => sub { $log_level = $log_verbose },
    'debug'     => sub { $log_level = $log_debug },
    'update!'   => \$update,
    'root!'     => \$root,
    'exclude=s' => \@exclude,
) or die $usage;

@ARGV == 2 or die $usage;
$zipfile = shift @ARGV;
$tree    = shift @ARGV;

### Report functions

sub debug ($$) {
    my $type = shift;
    my $data = shift;
    print "[$type] $data\n" if $log_level >= $log_debug;
    1;
}
sub verbose ($$) {
    my $type = shift;
    my $data = shift;
    print "[$type] $data\n" if $log_level >= $log_verbose;
}
sub info ($$) {
    my $type = shift;
    my $data = shift;
    print "[$type] $data\n" if $log_level >= $log_normal;
    1;
}
sub warning ($) {
    my $msg = shift;
    $count_warn++;
    warn "$warning $msg\n";
    1;
}

### File operations

sub excluded ($) {
    my $file = shift;
    $count_exclude++;
    info 'excluded', $file;
    1;
}
sub changemod ($$) {
    my $mode = shift;
    my $file = shift;
    my $chmod = sprintf('chmod %lo', $mode);
    $count_mode++;
    info $chmod, $file;
    chmod $mode, $file or warning "Mode change failed: $file";
}
sub touch ($$) {
    my $time = shift;
    my $dir = shift;
    my $mtime = (stat $dir)[9];
    if ($mtime != $time) {
        $count_time++;
        info 'touch', $dir;
        utime $time, $time, $dir or warning "Time update failed: $dir";
    }
}

### Title
print $title if $log_level >= $log_normal;

use Cwd qw(getcwd abs_path);
use File::Spec::Functions;

# check $tree
-d $tree or die "$error Directory does not exist: $tree\n";

# zip file name
$zipfile =~ /\.zip$/ or
    die "$error Wrong file extension of zip file: $zipfile\n";

# Option --noroot requires directory change because of program zip.
my $cwd;
if ($root) {
    verbose 'zipfile', $zipfile;
}
else {
    # adjust path of zipfile
    $zipfile = abs_path($zipfile);
    verbose 'zipfile', $zipfile;

    # change directory
    debug 'curdir', getcwd;
    chdir $tree or die "$error Cannot change directory: $tree\n";
}
debug 'workdir', getcwd;

my @list; # stores names as input for program zip

# directory permissions should be checked before traversal
if ($root) {
    my $mode = (stat($tree))[2];
    changemod $mode_directory, $tree unless $mode == $mode_directory;
}

sub traverse ($);
sub traverse ($) {
    my $dir = shift;

    my $traverse_dir = ($dir) ? $dir : curdir;
    debug 'traverse', $traverse_dir;
    unless (opendir DIR, $traverse_dir) {
        warning "Cannot open directory: $traverse_dir";
        return 0;
    }
    my @sub_list  = sort
                    grep { !/^[.]{1,2}$/ }
                    readdir DIR;
    @sub_list = map { catfile $dir, $_ } @sub_list if $dir;
    closedir DIR;
    if ($dir) {
        push @list, $dir;
        $count_dir++;
    }

    my @sub_dirs;
    my @sub_files;

    for (@sub_list) {
        if (-d $_) {
            push @sub_dirs, $_;
            next;
        }
        if (-f $_) {
            push @sub_files, $_;
            next;
        }
        warning "Unknown file type ignored: $_";
    }

    for my $exclude (@exclude) {
        @sub_dirs  = grep { not("$_/" =~ /$exclude/ and excluded "$_/") }
                     @sub_dirs;
        @sub_files = grep { not(/$exclude/ and excluded $_) }
                     @sub_files;
    }

    @sub_dirs = grep { traverse $_ } @sub_dirs;
    push @list, @sub_files;
    $count_file += @sub_files;

    my $time_max = 0;
    for (@sub_dirs, @sub_files) {
        my ($mode, $mtime) = (stat $_)[2,9];

        $time_max = $mtime if $mtime > $time_max;

        if (-d $_) {
            changemod $mode_directory, $_ unless $mode == $mode_directory;
        }
        else {
            my $mode_file = ((-x $_) ? $mode_file_exec : $mode_file_regular);
            changemod $mode_file, $_ unless $mode == $mode_file;
        }
    }

    touch $time_max, $dir if $dir;

    1;
}

traverse(($root) ? $tree : '');

if (-f $zipfile) {
     if ($update) {
         info 'update', $zipfile;
     }
     else {
        info 'delete/create', $zipfile;
        unlink $zipfile or warning "Cannot delete: $zipfile";
    }
}
else {
    info 'create', $zipfile;
}

my $opts = " -o$compression";
$opts .= "v" if $log_level >= $log_debug;
$opts .= "q" if $log_level <= $log_normal;
my $pipe = "|$prg_zip$opts $zipfile -\@";
debug 'zip call', $pipe;

open(ZIP, $pipe) or die "$error Cannot start `zip'!\n";
for (@list) {
    print ZIP "$_\n";
}
close(ZIP) or
    die $! ? "$error Closing `zip': $!\n"
           : "$error `zip' reports error code $?\n";

-f $zipfile or die "$error Missing result zip file: $zipfile\n";

info 'stats', "$count_exclude entries excluded" if $count_exclude > 1;
info 'stats', "$count_exclude entry excluded" if $count_exclude == 1;
info 'stats', "$count_mode mode changes" if $count_mode > 1;
info 'stats', "$count_mode mode change" if $count_mode == 1;
info 'stats', "$count_time time updates" if $count_time > 1;
info 'stats', "$count_time time update" if $count_time == 1;
info 'stats', "$count_dir directories added" if $count_dir != 1;
info 'stats', "$count_dir directory added" if $count_dir == 1;
info 'stats', "$count_file files added" if $count_file != 1;
info 'stats', "$count_file file added" if $count_file == 1;
info 'stats', "$count_warn warnings" if $count_warn > 1;
info 'stats', "$count_warn warning" if $count_warn == 1;

my $size = (stat $zipfile)[7];
$size = join '', reverse split '', $size;
$size =~ s/(\d\d\d)/$1./g;
$size =~ s/\.$//;
$size = join '', reverse split '', $size;

print "--> $zipfile ($size bytes)\n" if $log_level >= $log_normal;

__END__
