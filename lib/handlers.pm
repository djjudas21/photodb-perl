package handlers;

# This package provides reusable handlers to be interact with the user

use strict;
use warnings;

use Exporter qw(import);
use Data::Dumper;
use Config::IniHash;

our @EXPORT = qw(film_add);

sub film_add {
	# Add a newly-purchased film
	my $db = shift;
	my %data;
	$data{'filmstock_id'} = &listchoices($db, 'filmstock', "select filmstock_id as id, name as opt from FILMSTOCK");
	$data{'format_id'} = &listchoices($db, 'format', "select format_id as id, format as opt from FORMAT");
	$data{'frames'} = prompt('', 'How many frames?', 'integer');
	if (prompt('no', 'Is this film bulk-loaded?', 'boolean') == 1) {
		$data{'film_bulk_id'} = &listchoices($db, 'bulk film', "select * from choose_bulk_id");
		$data{'film_bulk_loaded'} = prompt(&today($db), 'When was the film bulk-loaded?');
	} else {
		$data{'film_batch'} = prompt('', 'Film batch number', 'text');
		$data{'film_expiry'} = prompt('', 'Film expiry date', 'date');
	}
	$data{'purchase_date'} = prompt(&today($db), 'Purchase date', 'date');
	$data{'price'} = prompt('', 'Purchase price', 'decimal');
	&newrecord($db, \%data, 'FILM');
}
