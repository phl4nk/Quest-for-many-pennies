#!/usr/bin/perl
# DiceTr0ll
# simple dice bot with no feelings...

use strict;
use warnings;
use LWP::UserAgent;
use WWW::UserAgent::Random;
use JSON;
use Data::Dumper;

my $accessToken = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
my $wager = '0.00000001';
my $chance = '49.5';
my $direction = 0;
my $server_endpoint = "https://betterbets.io/api/betDice/";
my $weight = 0.0;
my $i =0;
my $final_wager = $wager;
my $ua = LWP::UserAgent->new(agent => rand_ua(""));
my $req = HTTP::Request->new(POST => $server_endpoint);
$req->header('content-type' => 'application/x-www-form-urlencoded');

# pew pew
while (1){
	my $post_data = "accessToken=$accessToken&wager=$final_wager&chance=$chance&direction=$direction";
	$req->content($post_data);
	my $resp = $ua->request($req);
	if ($resp->is_success) {
		my $bet = decode_json($resp->decoded_content);
		if ($bet->{'win'} eq 0 and $i<8){
			my $rounded = sprintf("%.8f",($final_wager *=2.1));
			$final_wager =$rounded;
			$i++;
			print "[-] Balance: $bet->{'balance'}\n";
		}else{
			print "[+] Balance: $bet->{'balance'}\n";
			$i =0;
			$final_wager = $wager;
		}
	}
}
