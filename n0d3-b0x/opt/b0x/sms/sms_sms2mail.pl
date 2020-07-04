#!/usr/bin/perl

my $spooldir = '/var/spool/gammu/inbox/';
my $file = undef;
my $date = undef;
my $tel = undef;
my $subject = undef;

# CHANGE THIS EMAIL-ADDRESS
my $recipient = 'root';

opendir(D,$spooldir) || die "Can't open dir: $!\n";

while($file = readdir(D))
{
        if($file =~ m/IN(\d\d\d\d)(\d\d)(\d\d)_(\d\d)(\d\d)\d\d_\d{1,2}_(.*)_\d{1,2}.txt/g)
        {
                $date = "$1-$2-$3 $4:$5";
                $tel = $6;
                $subject = "SMS from $tel at $date";

                `cat $spooldir/$file | mail -s "$subject" -- $recipient`;
                unlink "$spooldir/$file";
        }
}

closedir(D);