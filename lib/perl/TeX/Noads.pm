package TeX::Noads;

use strict;
use warnings;

use Carp;

use base qw(Exporter);

our %EXPORT_TAGS = (factories => [ qw(make_noad
                                      make_accent_noad
                                      make_bin_noad
                                      make_close_noad
                                      make_fraction_noad
                                      make_inner_noad
                                      make_left_noad
                                      make_op_noad
                                      make_open_noad
                                      make_ord_noad
                                      make_over_noad
                                      make_punct_noad
                                      make_radical_noad
                                      make_rel_noad
                                      make_right_noad
                                      make_under_noad
                                      make_vcenter_noad
                                      make_choice_node
                                   ) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{factories} } );

our @EXPORT =  ( @{ $EXPORT_TAGS{factories} } );

use TeX::WEB2C qw(:math_params);

use TeX::Noad::AccentNoad;
use TeX::Noad::BinNoad;
use TeX::Noad::CloseNoad;
use TeX::Noad::FractionNoad;
use TeX::Noad::InnerNoad;
use TeX::Noad::LeftNoad;
use TeX::Noad::MathChar;
use TeX::Noad::OpNoad;
use TeX::Noad::OpenNoad;
use TeX::Noad::OrdNoad;
use TeX::Noad::OverNoad;
use TeX::Noad::PunctNoad;
use TeX::Noad::RadicalNoad;
use TeX::Noad::RelNoad;
use TeX::Noad::RightNoad;
use TeX::Noad::UnderNoad;
use TeX::Noad::VcenterNoad;

my @NOAD_MAP;

$NOAD_MAP[ord_noad - ord_noad]      = "OrdNoad";
$NOAD_MAP[op_noad - ord_noad]       = "OpNoad";
$NOAD_MAP[bin_noad - ord_noad]      = "BinNoad";
$NOAD_MAP[rel_noad - ord_noad]      = "RelNoad";
$NOAD_MAP[open_noad - ord_noad]     = "OpenNoad";
$NOAD_MAP[close_noad - ord_noad]    = "CloseNoad";
$NOAD_MAP[punct_noad    - ord_noad]    = "PunctNoad";
$NOAD_MAP[inner_noad    - ord_noad]    = "InnerNoad";
$NOAD_MAP[radical_noad  - ord_noad]  = "RadicalNoad";
$NOAD_MAP[fraction_noad - ord_noad] = "FractionNoad";
$NOAD_MAP[under_noad    - ord_noad]    = "UnderNoad";
$NOAD_MAP[over_noad - ord_noad]     = "OverNoad";
$NOAD_MAP[accent_noad - ord_noad]   = "AccentNoad";
$NOAD_MAP[vcenter_noad - ord_noad]  = "VcenterNoad";
$NOAD_MAP[left_noad - ord_noad]     = "LeftNoad";
$NOAD_MAP[right_noad - ord_noad]    = "RightNoad";

sub make_noad( $;$$$ ) {
    my $type     = shift;

    my $nucleus   = shift;
    my $subscript = shift;
    my $supscript = shift;

    my $class = $NOAD_MAP[$type] || croak "Unknown noad type $type";

    my $noad = "TeX::Noad::$class"->new({ nucleus   => $nucleus,
                                          subscript => $subscript,
                                          supscript => $supscript });

    return $noad;
}

my $TEMPLATE = q{
    sub make_%s_noad($;$$) {
        my $nucleus   = shift;
        my $subscript = shift;
        my $supscript = shift;

        return "TeX::Noad::%sNoad"->new({ nucleus   => $nucleus,
                                          subscript => $subscript,
                                          supscript => $supscript });
    }
};

for my $noad (qw(Bin Close Inner Op Open Ord Over Punct Rel Under Vcenter)) {
    eval sprintf $TEMPLATE, lc($noad), $noad;
}

sub make_accent_noad($$;$$) {
    my $accent = shift;

    my $nucleus   = shift;
    my $subscript = shift;
    my $supscript = shift;

    return "TeX::Noad::AccentNoad"->new(accent    => $accent,
                                        nucleus   => $nucleus,
                                        subscript => $subscript,
                                        supscript => $supscript);
}

sub make_left_noad($$;$$) {
    my $character = shift;

    my $nucleus   = shift;
    my $subscript = shift;
    my $supscript = shift;

    return "TeX::Noad::LeftNoad"->new(character => $character,
                                      nucleus   => $nucleus,
                                      subscript => $subscript,
                                      supscript => $supscript);
}

sub make_right_noad($$;$$)  {
    my $character = shift;

    my $nucleus   = shift;
    my $subscript = shift;
    my $supscript = shift;

    return "TeX::Noad::RightNoad"->new(character => $character,
                                       nucleus   => $nucleus,
                                       subscript => $subscript,
                                       supscript => $supscript);
}

sub make_radical_noad($$;$$)  {
    my $character = shift;

    my $nucleus   = shift;
    my $subscript = shift;
    my $supscript = shift;

    return "TeX::Noad::RadicalNoad"->new(character => $character,
                                         nucleus   => $nucleus,
                                         subscript => $subscript,
                                         supscript => $supscript);
}

sub make_fraction_noad($;$)  {
    my $numerator = shift;
    my $denominator = shift;

    return TeX::Noad::FractionNoad({ numerator   => $numerator,
                                     denominator => $denominator });
}

sub make_choice_node {
    return TeX::Noad::ChoiceNode->new();
}

1;

__END__
