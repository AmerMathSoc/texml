package TeX::FMT::File;

use strict;
use warnings;

use version; our $VERSION = qv '1.3.1';

use Carp;

use integer;

use Fcntl qw(:seek);

use TeX::Arithmetic qw(scaled_to_string);

use TeX::Utils;
use TeX::Utils::Binary;

use TeX::FMT::Eqtb;
use TeX::FMT::Hash;
use TeX::FMT::Mem;
use TeX::FMT::MemoryWord;

use TeX::FMT::Parameters::Utils qw(print_esc);

use TeX::Font qw(:factories);

use TeX::FMT::Parameters;

use base qw(TeX::BinaryFile);

use TeX::Class;

my %fmt_format   :ATTR(:get<fmt_format> :set<fmt_format>);
my %engine       :ATTR(:get<engine>     :set<engine>);

my %debug_mode_of :BOOLEAN(:name<debug_mode> :get<debug_mode> :default<0>);

my %params_of :ATTR(:name<params>);

my %xord         :ATTR(:get<xord> :set<xord>);
my %xchr         :ATTR(:get<xchr> :set<xchr>);
my %xprn         :ATTR(:get<xprn> :set<xprn>);

my %max_halfword :ATTR(:get<max_halfword> :set<max_halfword>);
my %hash_high    :ATTR(:get<hash_high>    :set<hash_high>);
my %hash_used    :ATTR(:get<hash_used>    :set<hash_used>);
my %mem_bot      :ATTR(:get<mem_bot>      :set<mem_bot>);
my %mem_top      :ATTR(:get<mem_top>      :set<mem_top>);
my %eqtb_size    :ATTR(:get<eqtb_size>    :set<eqtb_size>);
my %hash_prime   :ATTR(:get<hash_prime>   :set<hash_prime>);

my %hyph_prime   :ATTR(:get<hyph_prime>   :set<hyph_prime>);
my %hyph_count   :ATTR(:get<hyph_count>   :set<hyph_count>);
my %hyph_next    :ATTR(:get<hyph_next>    :set<hyph_next>);

my %eTeX_mode    :ATTR(:get<eTeX_mode>    :set<eTeX_mode> :default(0));
my %mltex_p      :ATTR(:get<mltex_p>      :set<mltex_p>  :default(0));
my %enctex_p     :ATTR(:get<enctex_p>     :set<enctex_p> :default(0));

my %pool_ptr     :ATTR(:get<pool_ptr>     :set<pool_ptr>);
my %str_ptr      :ATTR(:get<str_ptr>      :set<str_ptr>);
my %strings      :ATTR(:get<strings>      :set<strings>);

my %lo_mem_max   :ATTR(:get<lo_mem_max>   :set<lo_mem_max>);
my %hi_mem_min   :ATTR(:get<hi_mem_min>   :set<hi_mem_min>);
my %var_used     :ATTR(:get<var_used>     :set<var_used>);
my %dyn_used     :ATTR(:get<dyn_used>     :set<dyn_used>);
my %rover        :ATTR(:get<rover>        :set<rover>);
my %avail        :ATTR(:get<avail>        :set<avail>);

my %cs_count     :ATTR(:get<cs_count>     :set<cs_count>);

my %mem          :ATTR(:get<mem>          :set<mem>);
my %eqtb         :ATTR(:get<eqtb>         :set<eqtb>);
my %hash         :ATTR(:get<hash>         :set<hash>);

my %fmem_ptr     :ATTR(:get<fmem_ptr>     :set<fmem_ptr>);
my %font_ptr     :ATTR(:get<font_ptr>     :set<font_ptr>);
my %font_info    :ATTR(:get<font_info>    :set<font_info>);
my %font_checks  :ATTR(:get<font_checks>  :set<font_checks>);
my %font_sizes   :ATTR(:get<font_sizes>   :set<font_sizes>);
my %font_dsizes  :ATTR(:get<font_dsizes>  :set<font_dsizes>);
my %font_names   :ATTR(:get<font_names>   :set<font_names>);

my %format_ident :ATTR(:get<format_ident> :set<format_ident>);
my %interaction  :ATTR(:get<interaction_level>  :set<interaction_level>);

my %checksum :ATTR(:get<checksum>, :set<checksum>);

my %font_map :ATTR(:get<font_map>);

use constant MEM_WORD_LENGTH => 8;
use constant FMEM_WORD_LENGTH => 4;

use constant BYTES_PER_INT => 4;

use constant W2TX_CONSTANT => unpack("N", "W2TX"); # 3.141592 + W2C 7.4.5

use constant MLTX_CONSTANT => unpack("N", "MLTX");
use constant ECTX_CONSTANT => unpack("N", "ECTX");

use constant {
    IMAGE_TYPE_NONE  => 0,
    IMAGE_TYPE_PDF   => 1,
    IMAGE_TYPE_PNG   => 2,
    IMAGE_TYPE_JPG   => 3,
    IMAGE_TYPE_TIF   => 4,
    IMAGE_TYPE_JBIG2 => 5,
};

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    $self->set_mem(TeX::FMT::Mem->new());
    $self->set_eqtb(TeX::FMT::Eqtb->new());
    $self->set_hash(TeX::FMT::Hash->new({ fmt => $self }));

    $self->get_mem()->set_fmt($self);

    $font_map{$ident} = [];

    return;
}

sub __check( $$$ ) {
    my $name     = shift;
    my $expected = shift;
    my $found    = shift;

    # warn sprintf "Bad $name: Expected %04X, got %04X\n", $expected, $found;
    if ($expected != $found) {
        warn sprintf "Bad $name: Expected %d, got %d\n", $expected, $found;
    }

    return;
}

sub get_font {
    my $self = shift;

    my $fnt_num = shift;

    my $font_map = $self->get_font_map();

    if (! exists $font_map->[$fnt_num]) {
        my $font_name = $self->get_font_name($fnt_num);
        my $font_size = $self->get_font_size($fnt_num);

        $font_map->[$fnt_num] = load_font($font_name, $font_size);
    }

    return $font_map->[$fnt_num];
}

sub get_string {
    my $self = shift;
    my $num  = shift;

    return $self->get_strings()->[$num];
}

sub list_strings {
    my $self = shift;

    my @strings = @{ $strings{ident $self} };

    print "\nSTRING POOL:\n\n";

    for (my $i = 0; $i < @strings; $i++) {
        if (defined $strings[$i]) {
            print "string($i) = '$strings[$i]'\n";
        }
    }

    print "\n";

    return;
}

sub read_memory_word {
    my $self = shift;

    my $record = $self->read_bytes(MEM_WORD_LENGTH);

    return TeX::FMT::MemoryWord->new( { record => $record } );
}

sub read_memory_words {
    my $self = shift;

    my $n = shift;

    my @words;

    $#words = $n - 1;

    for my $i (0..$n-1) {
        $words[$i] = $self->read_memory_word();
    }

    return @words;
}

sub read_fmemory_words {
    my $self = shift;

    my $n = shift;

    my @words;

    $#words = $n - 1;

    for my $i (0..$n-1) {
        $words[$i] = $self->read_bytes(FMEM_WORD_LENGTH);
    }

    return @words;
}

sub read_integer {
    my $self = shift;

    return $self->read_signed(BYTES_PER_INT);
}

sub read_integers {
    my $self = shift;

    my $n = shift;

    my @ints;
    $#ints = $n - 1;

    for my $i (0..$n-1) {
        $ints[$i] = $self->read_integer();
    }

    return @ints;
}

sub read_shorts {
    my $self = shift;

    my $n = shift;

    my @shorts;
    $#shorts = $n - 1;

    for my $i (0..$n-1) {
        $shorts[$i] = $self->read_signed(2);
    }

    return @shorts;
}

sub read_unsigned_shorts {
    my $self = shift;

    my $n = shift;

    my @shorts;
    $#shorts = $n - 1;

    for my $i (0..$n-1) {
        $shorts[$i] = $self->read_unsigned(2);
    }

    return @shorts;
}

sub read_unsigned_chars {
    my $self = shift;

    my $n = shift;

    my @chars;
    $#chars = $n - 1;

    for my $i (0..$n-1) {
        $chars[$i] = $self->read_unsigned(1);
    }

    return @chars;
}

sub read_signed_chars {
    my $self = shift;

    my $n = shift;

    my @chars;
    $#chars = $n - 1;

    for my $i (0..$n-1) {
        $chars[$i] = $self->read_signed(1);
    }

    return @chars;
}

sub read_hh {
    my $self = shift;

    my $record = $self->read_bytes(BYTES_PER_INT);

    return TeX::FMT::MemoryWord->new( { record => $record } );
}

sub load {
    my $self = shift;

    $self->load_through_eqtb();

    $self->load_font_info();

    $self->load_hyphenation_tables();

    if ($self->get_engine() eq 'pdftex') {
        $self->load_pdftex_data();
    }

    $self->finish_load();

    return;
}

sub load_through_eqtb {
    my $self = shift;

    $self->load_header();

    $self->load_constants();

    $self->load_mltex_data();

    if ($self->get_fmt_format() == 3) {
        $self->load_enctex_data();
    }

    $self->load_string_pool();

    $self->load_dynamic_memory();

    $self->load_eqtb();

    return;
}

sub load_header {
    my $self = shift;

    # $LOG->verbose("Loading fmt file\n");

    my $checksum = $self->read_integer();

    if ($checksum == W2TX_CONSTANT) {
        $self->set_fmt_format(3);

        $self->load_format_engine();

        $checksum = $self->read_integer();

        $self->load_translation_tables();
    } else {
        $self->set_fmt_format(2);

        $self->set_engine('tex');
    }

    my $params = get_engine_parameters($self->get_engine());

    $self->set_params($params);
    $self->get_eqtb()->set_params($params);

    $self->set_checksum($checksum);

    return;
}

sub load_format_engine {
    my $self = shift;

    my $engine = $self->read_string(4);

    $engine =~ s/\000+$//g;

    # $LOG->debug("engine = '$engine'\n");

    $self->set_engine($engine);

    return;
}

sub load_translation_tables {
    my $self = shift;

    # $LOG->verbose("Loading translation\n");

    my @xord = unpack("C*", $self->read_bytes(256));
    my @xchr = unpack("C*", $self->read_bytes(256));
    my @xprn = unpack("C*", $self->read_bytes(256));

    $self->set_xord(\@xord);
    $self->set_xchr(\@xchr);
    $self->set_xprn(\@xprn);

    return;
}

sub load_constants {
    my $self = shift;

    # $LOG->verbose("Loading constants\n");

    my $params = $self->get_params();

    my $max_halfword = $self->read_integer();

    __check "max_halfword", $params->max_halfword(), $max_halfword;

    $self->set_max_halfword($max_halfword);

    $self->set_hash_high($self->read_integer());

    if ($self->get_engine() eq 'pdftex') {
        my $eTeX_mode = $self->read_integer();

        # $LOG->debug("eTeX_mode = $eTeX_mode\n");

        $self->set_eTeX_mode($eTeX_mode);
    }

    my $mem_bot = $self->read_integer();

    __check "mem_bot", $params->mem_bot(), $mem_bot;

    $self->set_mem_bot($mem_bot);

    my $mem_top = $self->read_integer();

    $self->set_mem_top($mem_top);
    $self->get_mem()->set_mem_top($mem_top);

    $self->set_eqtb_size($self->read_integer());

    my $hash_prime = $self->read_integer();

    __check "hash_prime", $params->hash_prime(), $hash_prime;

    $self->set_hash_prime($hash_prime);

    my $hyph_prime = $self->read_integer();

    __check "hyph_prime", $params->hyph_prime(), $hyph_prime;

    $self->set_hyph_prime($hyph_prime);

    return;
}

sub load_mltex_data {
    my $self = shift;

    my $mltex_magic = $self->read_integer();

    __check "MLTeX magic", MLTX_CONSTANT, $mltex_magic;

    $self->set_mltex_p($self->read_integer());

    return;
}

sub load_enctex_data {
    my $self = shift;

    my $magic = $self->read_integer();

    __check "encTeX magic", ECTX_CONSTANT, $magic;

    my $enctex_p = $self->read_integer();

    $self->set_enctex_p($enctex_p);

    if ($enctex_p) {
        $self->skip(256); # mubyte_read[]
        $self->skip(256); # mubyte_write[]
        $self->skip(128); # mubyte_cswrite[]
    }

    return;
}

sub load_string_pool {
    my $self = shift;

    # $LOG->verbose("Loading string pool\n");

    my $pool_ptr = $self->read_integer();
    my $str_ptr  = $self->read_integer();

    $self->set_pool_ptr($pool_ptr);
    $self->set_str_ptr($str_ptr);

    my @str_start = unpack("N*", $self->read_bytes(BYTES_PER_INT * ($str_ptr + 1)));

    my @strings;
    $#strings = $str_ptr - 1;

    for my $i (0..$str_ptr - 1) {
        my $len = $str_start[$i + 1] - $str_start[$i];

        if ($len > 0) {
            $strings[$i] = $self->read_bytes($len);
        } else {
            $strings[$i] = '';
        }

        # $LOG->debug("string[$i] = '$strings[$i]'\n");
    }

    $self->set_strings(\@strings);

    return;
}

sub load_dynamic_memory {
    my $self = shift;

    # $LOG->verbose("Loading dynamic memory\n");

    my $params = $self->get_params();

    my $mem = $self->get_mem();

    my $lo_mem_max = $self->read_integer();
    my $rover      = $self->read_integer();

    $self->set_lo_mem_max($lo_mem_max);
    $self->get_mem()->set_lo_mem_max($lo_mem_max);
    $self->set_rover($rover);

    if ($self->get_eTeX_mode()) {
        for my $k ($params->int_val() .. $params->tok_val()) {
            $self->read_integer();
        }
    }

    my $p = $self->get_mem_bot();
    my $q = $rover;

    do {
        for my $ptr ($p .. $q + 1) {
            my $word = $self->read_memory_word();

            $mem->set_word($ptr, $word);
        }

        $p = $q + $mem->get_node_size($q);
        $q = $mem->get_rlink($q);
    } until ($q == $rover);

    for my $ptr ($p .. $lo_mem_max) {
        my $word = $self->read_memory_word();

        $mem->set_word($ptr, $word);
    }

    my $hi_mem_min = $self->read_integer();
    my $avail      = $self->read_integer();

    $self->set_hi_mem_min($hi_mem_min);
    $self->get_mem()->set_hi_mem_min($hi_mem_min);
    $self->set_avail($avail);

    my $mem_end = $self->get_mem_top();

    for my $ptr ($hi_mem_min .. $mem_end) {
        my $word = $self->read_memory_word();

        $mem->set_word($ptr, $word);
    }

    my $var_used = $self->read_integer();
    my $dyn_used = $self->read_integer();

    $self->set_var_used($var_used);
    $self->set_dyn_used($dyn_used);

    return;
}

sub load_eqtb {
    my $self = shift;

    # $LOG->verbose("Loading eqtb\n");

    my $params = $self->get_params();

    my $eqtb_size = $self->get_eqtb_size();

    my $eqtb = $self->get_eqtb();

    my $k = $params->active_base();

    do {
        my $x = $self->read_integer();

        for my $j ($k .. $k + $x - 1) {
            my $word = $self->read_memory_word();

            # $LOG->debug("load_eqtb: word($j) = $word\n");

            $eqtb->set_word($j, $word);
        }

        $k += $x;

        $x = $self->read_integer();

        if ($x > 0) {
            my $last_word = $eqtb->get_word($k - 1);

            for my $j ($k .. $k + $x - 1) {
                # $LOG->debug("load_eqtb: word($j) = $last_word (last_word)\n");

                $eqtb->set_word($j, $last_word);
            }

            $k += $x;
        }
    } until $k > $eqtb_size;

    my $hash_high = $self->get_hash_high();

    for my $ptr ($eqtb_size + 1 .. $eqtb_size + $hash_high) {
        my $word = $self->read_memory_word();

        $eqtb->set_word($ptr, $word);
    }

    my $par_loc   = $self->read_integer();
    my $write_loc = $self->read_integer();

    $self->load_hash_table();

    return;
}

sub load_hash_table {
    my $self = shift;

    # $LOG->verbose("Loading hash table\n");

    my $params = $self->get_params();

    if ($params->prim_size() > 0) {
        # $LOG->verbose("Loading primitives table\n");

        ## Skip over the prim and prim_eqtb tables used to implement
        ## the \pdfprimitive and \ifpdfprimitive extensions.

        my @prim;

        for (my $p = 0; $p <= $params->prim_size(); $p++) {
            $prim[$p] = $self->read_memory_word();
        }

        my @prim_eqtb;

        for (my $p = 0; $p <= $params->prim_size(); $p++) {
            $prim_eqtb[$p] = $self->read_memory_word();
        }
    }

    my $hash = $self->get_hash();
    my $eqtb = $self->get_eqtb();

    my $hash_used = $self->read_integer();

    $self->set_hash_used($hash_used);

    my $ptr = $params->hash_base() - 1;

    # $LOG->verbose("Reading hash region 1\n\n");

    do {
        my $next_ptr = $self->read_integer();

        if ($next_ptr < $ptr + 1 || $next_ptr > $hash_used) {
            die "Bad fmt: ptr = $ptr; next_ptr = $next_ptr; hash_used = $hash_used\n";

            # exit 1;
        }

        $ptr = $next_ptr;

        my $word = $self->read_memory_word();

        $hash->set_word($ptr, $word);
    } until $ptr == $hash_used;

    # $LOG->verbose("Reading hash region 2\n\n");

    for my $ptr ($hash_used + 1 .. $params->undefined_control_sequence() - 1) {
        my $word = $self->read_memory_word();

        $hash->set_word($ptr, $word);
    }

    # $LOG->verbose("Reading hash region 3\n\n");
    
    my $hash_high = $self->get_hash_high();

    if ($hash_high > 0) {
        my $eqtb_size = $self->get_eqtb_size();
        
        for my $ptr ($eqtb_size + 1 .. $eqtb_size + $hash_high) {
            my $word = $self->read_memory_word();

            $hash->set_word($ptr, $word);
        }
    }

    my $cs_count = $self->read_integer();

    $self->set_cs_count($cs_count);

    return;
}

sub load_font_info {
    my $self = shift;

    # $LOG->verbose("Loading font info\n");

    my $params = $self->get_params();

    my $fmem_ptr = $self->read_integer();

    if ($fmem_ptr < 7 || $fmem_ptr > $params->font_mem_size()) {
        die "Bad fmt: fmem_ptr = $fmem_ptr; font_mem_size=" . $params->font_mem_size() . "\n";
        # exit 1;
    }

    $self->set_fmem_ptr($fmem_ptr);

    my @font_info = $self->read_fmemory_words($fmem_ptr);

    my $font_ptr = $self->read_integer();

    $self->set_font_ptr($font_ptr);

    my $num_fonts = $font_ptr + 1;

    my @font_check = $self->read_integers($num_fonts);

    $self->set_font_checks(\@font_check);

    my @font_size        = $self->read_integers($num_fonts);
    my @font_dsize       = $self->read_integers($num_fonts);

    $self->set_font_sizes(\@font_size);
    $self->set_font_dsizes(\@font_dsize);

    my @font_params      = $self->read_integers($num_fonts);
    my @hyphen_char      = $self->read_integers($num_fonts);
    my @skew_char        = $self->read_integers($num_fonts);
    my @font_name        = $self->read_integers($num_fonts);

    $self->set_font_names(\@font_name);

    my @font_area        = $self->read_integers($num_fonts);
    my @font_bc          = $self->read_unsigned_chars($num_fonts);
    my @font_ec          = $self->read_unsigned_chars($num_fonts);
    my @char_base        = $self->read_integers($num_fonts);
    my @width_base       = $self->read_integers($num_fonts);
    my @height_base      = $self->read_integers($num_fonts);
    my @depth_base       = $self->read_integers($num_fonts);
    my @italic_base      = $self->read_integers($num_fonts);
    my @lig_kern_base    = $self->read_integers($num_fonts);
    my @kern_base        = $self->read_integers($num_fonts);
    my @exten_base       = $self->read_integers($num_fonts);
    my @param_base       = $self->read_integers($num_fonts);
    my @font_glue        = $self->read_integers($num_fonts);
    my @bchar_label      = $self->read_integers($num_fonts);
    my @font_bchar       = $self->read_shorts($num_fonts);
    my @font_false_bchar = $self->read_shorts($num_fonts);

    return;
}

sub load_hyphenation_tables {
    my $self = shift;

    # $LOG->verbose("Loading hyphenation tables\n");

    my $params = $self->get_params();

    my $hyph_count = $self->read_integer();
    my $hyph_next  = $self->read_integer();

    $self->set_hyph_count($hyph_count);
    $self->set_hyph_next($hyph_next);

    my $hyph_prime = $self->get_hyph_prime();

    my $hyph_size = $hyph_next; ## -1 ???

    my @hyph_link;
    my @hyph_list;
    my @hyph_word;

    my $j;

    for my $k (1 .. $hyph_count) {
        $j = $self->read_integer();

        if ($j < 0) {
            die "load_hyphenation_tables: Bad format: k = $k; j = $j\n";
            # exit 1;
        }

        if ($j > 65535) {
            $hyph_next = $j / 65536;
            $j -= $hyph_next * 65536;
        } else {
            $hyph_next = 0;
        }

        if ( $j >= $hyph_size || $hyph_next > $hyph_size) {
            die "Bad format: k=$k; j=$j; hyph_size=$hyph_size; hyph_next=$hyph_next\n";

            # exit 1;
        }

        $hyph_link[$j] = $hyph_next;
        $hyph_word[$j] = $self->read_integer();
        $hyph_list[$j] = $self->read_integer();
    }

    $j++;

    if ($j < $hyph_prime) {
        $j = $hyph_prime;
    }

    $hyph_next = $j;

    if ($hyph_next > $hyph_size) {
        $hyph_next = $hyph_prime;
    } elsif ($hyph_next >= $hyph_prime) {
        $hyph_next++;
    }

    $j = $self->read_integer(); # 'trie size'

    # my $trie_max = $j;

    if ($self->get_engine() eq 'pdftex') {
        my $hyph_start = $self->read_integer();
    }

    my @trie_trl = $self->read_integers($j + 1);
    my @trie_tro = $self->read_integers($j + 1);
    my @trie_trc = $self->read_unsigned_chars($j + 1);

    $j = $self->read_integer(); # 'trie op size'

    # my $trie_op_ptr = $j;

    my @hyf_distance = $self->read_signed_chars($j);
    unshift @hyf_distance, undef;

    my @hyf_num = $self->read_signed_chars($j);
    unshift @hyf_num, undef;

    my @hyf_next = $self->read_unsigned_shorts($j);
    unshift @hyf_next, undef;

    my @trie_used = ($params->min_quarterword()) x 256;

    my $k = 256;

    my @op_start;

    while ($j > 0) {
        $k = $self->read_integer();

        my $x = $self->read_integer();

        $trie_used[$k] = $x; # qi(x)

        $j -= $x;

        $op_start[$k] = $j;
    }

    return;
}

sub load_pdftex_data {
    my $self = shift;

    $self->undump_image_meta();

    my $pdf_mem_size = $self->read_integer();

    my @pdf_mem;

    my $pdf_mem_ptr = $self->read_integer();

    for my $k (1..$pdf_mem_ptr - 1) {
        push @pdf_mem, $self->read_integer();
    }

    my $obj_tab_size = $self->read_integer();
    my $obj_ptr      = $self->read_integer();
    my $sys_obj_ptr  = $self->read_integer();

    my @obj_tab;

    for my $k (1..$sys_obj_ptr) {
        $self->read_integer();
        $self->read_integer();
        $self->read_integer();
        $self->read_integer();

        # undump_int(obj_tab[k].int0);
        # undump_int(obj_tab[k].int1);
        #
        # obj_tab[k].int2 := -1;
        #
        # undump_int(obj_tab[k].int3);
        # undump_int(obj_tab[k].int4);
    }

    my $pdf_obj_count    = $self->read_integer();
    my $pdf_xform_count  = $self->read_integer();
    my $pdf_ximage_count = $self->read_integer();

    # Actually an array.
    my %head_tab;

    $head_tab{obj_type_obj}    = $self->read_integer();
    $head_tab{obj_type_xform}  = $self->read_integer();
    $head_tab{obj_type_ximage} = $self->read_integer();

    my $pdf_last_obj    = $self->read_integer();
    my $pdf_last_xform  = $self->read_integer();
    my $pdf_last_ximage = $self->read_integer();

    return;
}

sub undump_image_meta {
    my $self = shift;

    # $LOG->verbose("Reading image metadata\n");

    # my $pdfversion = shift;
    # my $pdfinclusionerrorlevel = shift;

    my $image_limit = $self->read_integer();
    my $cur_image   = $self->read_integer();

    for (my $img = 0; $img < $cur_image; $img++) {
        my $img_name = $self->read_string(4);

        my $img_type = $self->read_integer();
        my $img_color = $self->read_integer();
        my $img_width = $self->read_integer();
        my $img_height = $self->read_integer();
        my $img_xres = $self->read_integer();
        my $img_yres = $self->read_integer();
        my $img_pages = $self->read_integer();
        my $img_colorspace_ref = $self->read_integer();
        my $img_group_ref = $self->read_integer();

        if ($img_type == IMAGE_TYPE_PDF) {
            my $page_box = $self->read_integer();
            my $selected_page = $self->read_integer();
        } elsif ($img_type == IMAGE_TYPE_JBIG2) {
            my $selected_page = $self->read_integer();
        }
    }

    return;
}

sub finish_load {
    my $self = shift;

    # $LOG->verbose("Loading trailer\n");

    $self->set_interaction_level($self->read_integer());
    $self->set_format_ident($self->read_integer());

    my $magic_constant = $self->read_integer();

    if ($magic_constant != 69069) {
        warn "Invalid file tail: $magic_constant\n";
    }

    return;
}

sub slow_print( $ ) {
    my $string = shift;

    return join '', map { print_char_code(ord($_)) } split //, $string;
}

sub show_meaning {
    my $self = shift;
    my $csname = shift;

    my $params = $self->get_params();

    my $hash = $self->get_hash();

    my $eqtb_ptr;

    if (length($csname) == 1) {
        $eqtb_ptr = $params->single_base() + ord($csname);
    } elsif ($eqtb_ptr = $hash->lookup($csname)) {
        ## no-op
    } else {
        # $LOG->verbose(print_esc(slow_print($csname)) . ": **UNDEFINED**\n\n");

        return;
    }

    my $eq_type = $self->get_eqtb()->get_word($eqtb_ptr)->get_eq_type();

    # if ($eq_type < $params->call() || $eq_type > $params->long_outer_call()) {
        print print_esc(slow_print($csname)) . ": ";

        $self->show_eqtb_entry($eqtb_ptr);
    # }

    return;
}

sub show_active_char {
    my $self = shift;
    my $eqtb_ptr = shift;

    print print_char_code($eqtb_ptr - 1) . ": ";

    $self->show_eqtb_entry($eqtb_ptr);

    return;
}

sub show_eqtb_entry {
    my $self = shift;

    my $params = $self->get_params();

    my $eqtb_ptr = shift;

    my $eqtb = $self->get_eqtb();
    my $mem  = $self->get_mem();

    my $entry = $eqtb->get_word($eqtb_ptr);

    my $eq_type  = $entry->get_eq_type();
    my $eq_level = $entry->get_eq_level();
    my $equiv    = $entry->get_equiv();

    if ($eq_type == $params->set_font()) {
        $self->show_font_def($equiv);
    } else {
        my $meaning = $params->print_cmd_chr($eq_type, $equiv);

        if (! defined $meaning) {
            print "UNKNOWN: eq_type=$eq_type, equiv=$equiv";
        } else {
            print $meaning;
        }

        if ($params->call() <= $eq_type && $eq_type <= $params->long_outer_call()) {
            print ":";
            $mem->show_token_list($self, $equiv);
        } else {
            #$LOG->notify(" (primitive)");
        }
    }

    print "\n\n";

    return;
}

sub get_font_name {
    my $self = shift;

    my $fnt_num = shift;

    return $self->get_string($self->get_font_names()->[$fnt_num]);
}

sub get_font_size {
    my $self = shift;

    my $fnt_num = shift;

    return $self->get_font_sizes()->[$fnt_num];
}

sub get_font_dsize {
    my $self = shift;

    my $fnt_num = shift;

    return $self->get_font_dsizes()->[$fnt_num];
}

sub show_font_def {
    my $self = shift;
    my $fnt_num = shift;

    print "select font ";

    print slow_print($self->get_string($self->get_font_names()->[$fnt_num]));

    my $size  = $self->get_font_size($fnt_num);
    my $dsize = $self->get_font_dsize($fnt_num);

    if ($size != $dsize) {
        print " at ", scaled_to_string($size), "pt";
    }

    return;
}

sub get_equiv {
    my $self = shift;
    my $ptr = shift;

    return $self->get_eqtb()->get_equiv($ptr);
}

sub show_node_list {
    my $self = shift;
    my $ptr = shift;

    return $self->get_mem()->show_node_list($ptr);
}

sub show_box {
    my $self = shift;

    my $index = shift;

    if ($index < 0 || $index > 255) {
        croak "Invalid box register: $index";
    }

    my $params = $self->get_params();

    my $ptr = $self->get_equiv($params->box_base() + $index);

    if ($ptr == $params->null()) {
        print "\\box${index}=void\n";
    } else {
        print "\\box${index}=";
        $self->show_node_list($ptr);
    }

    return;
}

sub extract_box_register {
    my $self = shift;

    my $index = shift;

    my $params = $self->get_params();

    if ($index < 0 || $index > 255) {
        croak "Invalid box register: $index";
    }

    my $ptr = $self->get_equiv($params->box_base() + $index);

    if ($ptr == $params->null()) {
        return;
    }

    return $self->get_mem()->extract_node_list($ptr);

    return;
}

sub debug {
    my $self = shift;

    print "File format: ", $self->get_fmt_format(), "\n";
    print "TeX engine: ", $self->get_engine() || '???', "\n";
    print "checksum = ", $self->get_checksum(), "\n";

    # print "mltex_p      = ", $self->get_mltex_p(), "\n";
    # print "enctex_p     = ", $self->get_enctex_p(), "\n";

    print "max_halfword = ", $self->get_max_halfword(), "\n";
    print "hash_high    = ", $self->get_hash_high(), "\n";
    print "mem_bot      = ", $self->get_mem_bot(), "\n";
    print "mem_top      = ", $self->get_mem_top(), "\n";
    print "eqtb_size    = ", $self->get_eqtb_size(), "\n";
    print "hash_prime   = ", $self->get_hash_prime(), "\n";
    print "hyph_prime   = ", $self->get_hyph_prime(), "\n";
    print "hyph_count   = ", $self->get_hyph_count(), "\n";
    print "hyph_next    = ", $self->get_hyph_next(), "\n";
    print "hash_used    = ", $self->get_hash_used(), "\n";

    print "pool_ptr     = ", $self->get_pool_ptr(), "\n";
    print "str_ptr      = ", $self->get_str_ptr(), "\n";

    print "lo_mem_max   = ", $self->get_lo_mem_max(), "\n";
    print "hi_mem_min   = ", $self->get_hi_mem_min(), "\n";

    print "var_used     = ", $self->get_var_used(), "\n";
    print "dyn_used     = ", $self->get_dyn_used(), "\n";

    print "fmem_ptr     = ", $self->get_fmem_ptr(), "\n";
    print "font_ptr     = ", $self->get_font_ptr(), "\n";

    print "cs_count     = ", $self->get_cs_count(), "\n";

    print "rover        = ", $self->get_rover(), "\n";
    print "avail        = ", $self->get_avail(), "\n";

    my $str_number = $self->get_format_ident();

    print "format_ident = ", $self->get_string($str_number), "\n";
    print "interaction  = ", $self->get_interaction_level(), "\n";

    # eval { $self->show_meaning("rlap") };
    #
    # if ($@) {
    #     print "show_meaning error: $@\n";
    # }
    #
    # eval { $self->show_meaning("sum") };
    #
    # if ($@) {
    #     print "show_meaning error: $@\n";
    # }

    ##  print "XORD:\n";
    ##
    ##  my @xord = @{ $self->get_xord() };
    ##
    ##  for (my $i = 0; $i < @xord; $i++) {
    ##      print "\t$i: $xord[$i]\n";
    ##  }

    ##  print "XCHR:\n";
    ##
    ##  my @xchr = @{ $self->get_xchr() };
    ##
    ##  for (my $i = 0; $i < @xchr; $i++) {
    ##      print "\t$i: $xchr[$i]\n";
    ##  }

    ##  print "XPRN:\n";
    ##
    ##  my @xprn = @{ $self->get_xprn() };
    ##
    ##  for (my $i = 0; $i < @xprn; $i++) {
    ##      print "\t$i: $xprn[$i]\n";
    ##  }

    print "STRINGS:\n";

    my @strings = @{ $self->get_strings() };

    for (my $i = 0; $i < @strings; $i++) {
        print "\t$i: $strings[$i]\n";
    }

    return;
}

1;

__END__
