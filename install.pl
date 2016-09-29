#!/usr/bin/perl
use warnings;
use strict;

# Get script path and home path
use Cwd qw(abs_path);
use constant PATH_ROOT => abs_path();
use constant PATH_HOME => $ENV{'HOME'};

# Flags for prompt
use constant PROMPT_NO  => 'n';
use constant PROMPT_YES => 'y';

# ENV consts
use constant ENV_HOME => $ENV{HOME};

sub yesNoPrompt
{
    my $inquery = shift;
    my $defaultAnswer = shift || PROMPT_NO;

    my $prompt
        = $defaultAnswer eq PROMPT_NO
        ? '[' . PROMPT_YES . '/' . ( uc PROMPT_NO ) . ']'
        : '[' . ( uc PROMPT_YES ) . '/' . PROMPT_NO . ']';
    local $| = 1;
    print "$inquery $prompt ";
    chomp( my $answer = <STDIN> );
    $answer = lc substr $answer, 0, 1 if $answer;
    return !$answer ? $defaultAnswer eq PROMPT_YES : $answer eq PROMPT_YES;
}

my @fileConfigs = ( 'vimrc', 'zshrc', 'tmux.conf' );

foreach my $conf (@fileConfigs)
{
    my $file       = PATH_HOME . "/.$conf";
    my $fileExists = -e $file;
    if (!$fileExists
        || yesNoPrompt(
            "Configuration file \`$file\` exists, overwrite with symlink?")
        )
    {
        unlink $file;
        symlink PATH_ROOT . "/$conf", $file;
        print "Configuration symlink \`" . PATH_ROOT
            . "/$conf\` => \`$file\` set.\n";
    }
}

my @folders = ( '/.vim/backup', '/.vim/swap', '/.vim/undo' );

for my $folder (@folders)
{
    $folder = ENV_HOME . $folder;
    my $folderExists = -e $folder;
    if (!$folderExists
        && yesNoPrompt(
            "Folder \`$folder\` doesn't exist, create it?", PROMPT_YES
        )
        )
    {
        mkdir $folder;
        print "Folder \`$folder\` created.\n";
    }
}
