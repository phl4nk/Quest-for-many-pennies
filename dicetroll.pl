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
my $chance = '2.0';
my $direction = 0;
my $server_endpoint = "https://betterbets.io/api/betDice/";

my $ua = LWP::UserAgent->new(agent => rand_ua(""));
my $req = HTTP::Request->new(POST => $server_endpoint);
$req->header('content-type' => 'application/x-www-form-urlencoded');
my $post_data = "accessToken=$accessToken&wager=$wager&chance=$chance&direction=$direction";
$req->content($post_data);

# pew pew
my $resp = $ua->request($req);
if ($resp->is_success) {
	my $message = decode_json($resp->decoded_content);
	# smart bot shit here
	print Dumper $message;
}
