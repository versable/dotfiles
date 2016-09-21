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

sub yesNoPromp
{
    my $inquery = shift;
    my $defaultAnswer = shift || PROMPT_NO;

    my $prompt
        = $defaultAnswer eq PROMPT_NO
        ? '[' . PROMPT_YES . '/' . uc PROMPT_NO . ']'
        : '[' . uc PROMPT_YES . '/' . PROMPT_NO . ']';
    local $| = 1;
    print "$inquery $prompt ";
    chomp( my $answer = <STDIN> );
    $answer = substr lc $answer, 0, 1 if $answer;
    return !$answer ? $defaultAnswer eq PROMPT_YES : $answer eq PROMPT_YES;
}

my %fileConfigs = (
    'vimrc'     => 'Vim configuration file already exists, overwrite?',
    'zshrc'     => 'ZSH configuration file already exists, overwrite?',
    'tmux.conf' => 'Tmux configuration file already exists, overwrite?',
);

foreach my $conf ( keys %fileConfigs )
{
    my $file       = PATH_HOME . "/.$conf";
    my $fileExists = -e $file;
    if ( !$fileExists
        || yesNoPromp( $fileConfigs{$conf} ) )
    {
        unlink $file;
        symlink PATH_ROOT . "/$conf", $file;
    }
}
