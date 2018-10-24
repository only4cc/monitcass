use strict;
use warnings;
use Net::SMTP;
use MIME::Lite;

my $DEBUG = 1; # 1 Para "Depurar"
my $smtp_server = '10.32.16.56'; #'SMTPinterno.e-contact.cl';

my $from_address= shift ;
my $to_address 	= shift ; # Destino en e-contact.cl
my $to_cc       = shift ; 
my $subject     = shift ;
my $body_filename = shift;

open my $fh, '<',  $body_filename or die "No pude leer  $body_filename $!";
my $body          = do { local $/; <$fh> };
close($fh);
my $attach_fname  = shift; 

my $msg = MIME::Lite ->new (  
	From 	=> $from_address,
	To 		=> $to_address,
	Cc 		=> $to_cc,
	Subject => $subject,
	Data 	=> $body,
	Type	=> 'multipart/mixed'
#	Type 	=> 'text/html'
);

$msg->attach(
    Type     => 'TEXT',
    Data     => $body
);

if ( $attach_fname ) {
	$msg->attach(
		Type     => 'image/gif',
		Path     => $attach_fname,
		Filename => $attach_fname,
		Disposition => 'attachment'
	);
}

my $smtp = Net::SMTP->new(	$smtp_server, 
				Debug	=> $DEBUG,
				TLS 	=> 0,
			);
						
$smtp->mail($from_address);
$smtp->recipient($to_address);

if ($smtp->to($to_address)) {
	 $smtp->data();
	 $smtp->datasend("Subject: $subject");
	 $smtp->datasend("\n");
	 $smtp->datasend($msg->as_string());
	 $smtp->dataend();
	 print "enviado.\n";
} else {
	 print "Error: ", $smtp->message();
}
 
$smtp->quit;
