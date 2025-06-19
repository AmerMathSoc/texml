package TeX::Class v1.1.3;

use v5.26.0;

# Copyright (C) 2022, 2024, 2025 American Mathematical Society
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

# For more details see, https://github.com/AmerMathSoc/texml

# This code is experimental and is provided completely without warranty
# or without any promise of support.  However, it is under active
# development and we welcome any comments you may have on it.

# American Mathematical Society
# Technical Support
# Publications Technical Group
# 201 Charles Street
# Providence, RI 02904
# USA
# email: tech-support@ams.org

## This is a variant of PTG::Class that does not import any other
## AMS-specific modules, so it can be used by modules in the TeX
## hierarchy that we hope to eventually make portable.  It may also
## accumulate some TeX-specific modifications in the future, although
## there are none as of yet.

use warnings;

## This is a modified version of Class::Std, v0.011, with the
## following modifications:
##
## 1) New declarations: :ARRAY, :BOOLEAN, :COUNTER, :HASH
##
## 2) Generic set(), add(), and get() methods.
##
## 3) :type<> specifier for :ATTR and :ARRAY and corresponding
##    is_array () and type_of() methods for named attributes.
##
## 4) Optional tracing of attribute modification via the :trace()
##    specifier.
##
## 5) Eliminated "Missing initializer label" complaints.
##
## 6) :default<> specifiers are always interpreted as fragments of
##    perl code and are eval'ed in the same package where they are
##    declared.  Among other things, this means that if you want a
##    string literal, you have to supply a string literal:
##
##        :default<"string_literal">
##
##    not
##
##        :default<string_literal>
##
##    but the added flexibility is worth this small inconvenience.

## NEW ATTRIBUTE TYPES
##
## The new attribute types all require a :name<> specifier and are
## automatically given the following standard accessors:
##
## :ARRAY :
##
##     get_NAMEs()        : get the list of NAMES either as an array or a
##                          reference to an anonymous array, depending on
##                          context (see protect_array_attribute()).
##                          :getarray<>
##     delete_NAMES()     : Delete the entire list of NAMES.  :deleter<>
##
##     N.B.: Note the extra "s" appended to "get_NAMEs" and "delete_NAMEs"!
##
##     get_NAME(N)        : get the Nth NAME. :get<>
##     set_NAME(N, VAL)   : set the value of the Nth NAME. :set<>
##
##     pop_NAME()         : pop and return the last value from the
##                          NAME array. :pop<>
##     push_NAME(VALS)    : push VALS onto the end of the NAME array. :push<>
##
##     shift_NAME()       : shift and return the first value from the
##                          NAME array. :shift<>
##     unshift_NAME(VALS) : unshift VALS onto the front of the NAME
##                          array. :unshift<>
##
##     add_NAME(VAL)   : append VAL to list of NAMEs  (same as
##                       push_NAME(VAL), but only takes a single
##                       value.)  (DEPRECATED) :add<>
##
## :BOOLEAN : is_NAME() and set_NAME() (but see implementation in
##     __declare_BOOLEAN for exceptions to is_NAME() default).
##     set_NAME() allows values like "yes", "false", "NO", etc.
##
## :COUNTER : get_NAME(), incr_NAME() and decr_NAME().
##
## :get<> and :set<> act more or less as you would expect them to.  If
## you don't want standard accessors defined at all, you can
## specify :set<*custom*> and/or :get<*custom*>.

## BUG: Use of :set<*custom*> or :get<*custom*> inhibits the use of
## the generic set() or get() methods for that field, as well as the
## implicit init_arg setters inside new().  This is nasty.

## Initially I hoped to implement TeX::Class by subclassing
## Class::Std, but that was impossible because I need access to the
## lexical %attribute hash that is shared by MODIFY_HASH_ATTRIBUTES(),
## _DUMP, new(), and DESTROY().  But given the magnitude of the
## changes and the fact that Class::Std is no longer supported, there
## would have been no real benefit to subclassing anyway.

use overload;

use Carp;

use Scalar::Util;

use constant CUSTOM_ACCESSOR => '*custom*';

use constant {
    TRACE_SET    => 0b0001,
    TRACE_GET    => 0b0010,
    TRACE_DELETE => 0b0100,
};

BEGIN { *ID = \&Scalar::Util::refaddr; }

my (%attribute, %cumulative, %anticumulative, %restricted, %private, %overload);

my %attribute_by_name;
my %is_one_of_us;

my @exported_subs = qw(
    new
    clone
    add
    get
    hash_keys
    set
    is_array
    is_hash
    type_of
    DESTROY
    AUTOLOAD
    _DUMP
);

my @exported_extension_subs = qw(
    MODIFY_HASH_ATTRIBUTES
    MODIFY_CODE_ATTRIBUTES
);

sub import {
    my $caller = caller;

    no strict 'refs';

    *{ "${caller}::ident" } = \&Scalar::Util::refaddr;

    for my $sub ( @exported_subs ) {
        *{ "${caller}::$sub" } = \&{$sub};
    }

    for my $sub ( @exported_extension_subs ) {
        my $target = "${caller}::$sub";

        my $real_sub = *{ $target }{CODE} || sub { return @_[2..$#_] };

        no warnings 'redefine';

        *{ $target } = sub {
            my ($package, $referent, @unhandled) = @_;

            for my $handler ($sub, $real_sub) {
                next if ! @unhandled;

                @unhandled = $handler->($package, $referent, @unhandled);
            }

            return @unhandled;
        };
    }
}

my sub __nonempty( $ ) {
    my $string = shift;

    return unless defined $string;

    return $string =~ /\S/;
}

my sub __empty( $ ) {
    return ! __nonempty($_[0]);
}

sub _raw_str {
    my $pat = shift;

    return qr{ ('$pat') | ("$pat")
             | qq? (?:
                     /($pat)/ | \{($pat)\} | \(($pat)\) | \[($pat)\] | <($pat)>
                   )
             }xms;
}

sub _str {
    my $pat = shift;

    return qr{ '($pat)' | "($pat)"
             | qq? (?:
                     /($pat)/ | \{($pat)\} | \(($pat)\) | \[($pat)\] | <($pat)>
                   )
             }xms;
}

sub _extractor_for_pair_named {
    my ($key, $raw) = @_;

    $key = qr{\Q$key\E};

    my $str_key = _str($key);

    my $LDAB = "(?:\x{AB})";
    my $RDAB = "(?:\x{BB})";

    my $STR = $raw ? _raw_str( qr{.*?} ) : _str( qr{.*?} );
    my $NUM = qr{ ( [-+]? (?:\d+\.?\d*|\.\d+) (?:[eE]\d+)? ) }xms;

    my $matcher = qr{ :$key<  \s* ([^>]*) \s* >
                    | :$key$LDAB  \s* ([^$RDAB]*) \s* $RDAB
                    | :$key\( \s*  (?:$STR | $NUM )   \s* \)
                    | (?: $key | $str_key ) \s* => \s* (?: $STR | $NUM )
                    }xms;

    return sub {
        return undef if __empty $_[0];
        return $_[0] =~ $matcher ? $+ : undef;
    };
}

BEGIN {
    *_extract_default  = _extractor_for_pair_named('default', 'raw');
    *_extract_default_val = _extractor_for_pair_named('default_value', 'raw');
    *_extract_init_arg = _extractor_for_pair_named('init_arg');
    *_extract_get      = _extractor_for_pair_named('get');
    *_extract_size     = _extractor_for_pair_named('size');
    *_extract_getarray = _extractor_for_pair_named('getarray');
    *_extract_numarray = _extractor_for_pair_named('numarray');
    *_extract_deleter  = _extractor_for_pair_named('deletearray');
    *_extract_deletehash  = _extractor_for_pair_named('deletehash');
    *_extract_gethash  = _extractor_for_pair_named('gethash');
    *_extract_sethash  = _extractor_for_pair_named('sethash');
    *_extract_set      = _extractor_for_pair_named('set');
    *_extract_pop      = _extractor_for_pair_named('pop');
    *_extract_push     = _extractor_for_pair_named('push');
    *_extract_shift    = _extractor_for_pair_named('shift');
    *_extract_unshift  = _extractor_for_pair_named('unshift');
    *_extract_add      = _extractor_for_pair_named('add');
    *_extract_name     = _extractor_for_pair_named('name');
    *_extract_type     = _extractor_for_pair_named('type');
    *_extract_incr     = _extractor_for_pair_named('incr');
    *_extract_decr     = _extractor_for_pair_named('decr');
    *_extract_trace    = _extractor_for_pair_named('trace');
}

## This is more or less Class::Std's normal :ATTR

sub __declare_ATTR {
    my $package  = shift;
    my $referent = shift;
    my $config   = shift;

    $is_one_of_us{$package} = 1;

    my $name   = _extract_name($config);
    my $getter = _extract_get($config) || $name;
    my $setter = _extract_set($config) || $name;

    my $type = _extract_type($config) || '';

    my $init_arg = _extract_init_arg($config) || $name;

    my $trace = _extract_trace($config) || 0;

    my $spec = {
        name     => $name || $init_arg || $getter || $setter || '????',
        ref      => $referent,
        type     => $type,
        default  => _extract_default($config),
        init_arg => $init_arg,
        package  => $package,
    };

    if (__nonempty($name)) {
        $attribute_by_name{ "${package}::${name}" } = $spec;
    }

    if (__nonempty($getter) && $getter ne CUSTOM_ACCESSOR) {
        no strict 'refs';

        $spec->{getter} = *{ "${package}::get_${getter}" } = sub {
            my $self = shift;

            my $value = $referent->{ID($self)};

            if ($trace & TRACE_GET) {
                carp "*** GET: ${package}::get_${getter}() = '$value'";
            }

            return $value;
        };
    }

    if (__nonempty($name)) {
        my $deleter = "delete_${name}";

        no strict 'refs';

        $spec->{delete} = *{ "${package}::${deleter}" } = sub {
            my $value = delete $referent->{ID($_[0])};

            if ($trace & TRACE_DELETE) {
                carp "*** DELETE: ${package}::${deleter}()";
            }

            return $value;
        };
    }

    if (__nonempty($setter) && $setter ne CUSTOM_ACCESSOR) {
        no strict 'refs';

        if (__nonempty($type)) {
            $spec->{setter} = sub {
                croak "Missing new value in 'set_$setter'" unless @_ == 2;

                my ($self, $new_val) = @_;

                if (defined($new_val) && ! eval { $new_val->isa($type) }) {
                    croak "Incorrect value type in set_$setter";
                }

                if ($trace & TRACE_SET) {
                    carp "*** SET: ${package}::set_${setter}() = '$new_val'";
                }

                $referent->{ID($self)} = $new_val;

                return;
            };
        } else {
            $spec->{setter} = sub {
                croak "Missing new value in 'set_$setter'" unless @_ == 2;

                my ($self, $new_val) = @_;

                if ($trace & TRACE_SET) {
                    carp "*** SET: ${package}::set_${setter}() = '$new_val'";
                }

                $referent->{ID($self)} = $new_val;

                return;
            };
        }

        *{ "${package}::set_${setter}" } = $spec->{setter};
    } elsif (__nonempty($type)) {
        carp "Ignoring :type<$type> specifier";
    }

    return $spec;
}

my sub __parse_boolean($;$) {
    my $raw = shift;

    my $value_of_null = shift;

    return $value_of_null if ! defined $raw;

    return $raw if $raw =~ /^\d+$/;

    return 1 if $raw =~ /^(y(es?)?|t(r(ue?)?)?|(on?))$/i;

    return 0 if $raw =~ /^(no?|f(a(l(se?)?)?)?|(o(ff?)?))$/i;

    return $value_of_null;
}

sub __declare_BOOLEAN {
    my $package  = shift;
    my $referent = shift;
    my $config   = shift;

    $is_one_of_us{$package} = 1;

    if (__nonempty(my $type = _extract_type($config))) {
        carp "Ignoring redundant :type<$type> specifier on :BOOLEAN";
    }

    my $name = _extract_name($config);

    if (__empty($name)) {
        croak "Missing :name for BOOLEAN attribute";
    }

    my $init_arg = _extract_init_arg($config) || $name;

    my $trace = _extract_trace($config) || 0;

    my $spec = {
        name     => $name,
        ref      => $referent,
        type     => 'BOOLEAN',
        default  => _extract_default($config),
        init_arg => $init_arg,
        package  => $package,
    };

    if (__nonempty($name)) {
        $attribute_by_name{ "${package}::${name}" } = $spec;
    }

    my $getter = _extract_get($config);

    if (__empty($getter)) {
        if ($name =~ m{\A (do|is|has|needs|no|use|uses|allow)_}smx) {
            $getter = $name;
        } else {
            $getter = "is_$name";
        }
    }

    if ($getter ne CUSTOM_ACCESSOR) {
        no strict 'refs';

        $spec->{getter} = *{ "${package}::${getter}" } = sub {
            my $self = shift;

            my $value = $referent->{ID($self)};

            if ($trace & TRACE_GET) {
                carp "*** GET: ${package}::${getter}() = '$value'";
            }

            return $value;
        };
    }

    my $setter = _extract_set($config) || "set_$name";

    if ($setter ne CUSTOM_ACCESSOR) {
        no strict 'refs';

        $spec->{setter} = *{ "${package}::${setter}" } = sub {
            croak "Missing new value in '$setter'" unless @_ == 2;

            my ($self, $new_val) = @_;

            my $new_bool = __parse_boolean($new_val) ? 1 : 0;

            if ($trace & TRACE_SET) {
                carp "*** SET: ${package}::${setter}() = '$new_bool'";
            }

            $referent->{ID($self)} = $new_bool;

            return;
        };
    }

    return $spec;
}

sub __declare_COUNTER {
    my $package  = shift;
    my $referent = shift;
    my $config   = shift;

    $is_one_of_us{$package} = 1;

    if (__nonempty(my $type = _extract_type($config))) {
        carp "Ignoring redundant :type<$type> specifier on :COUNTER";
    }

    my $name = _extract_name($config);

    if (__empty($name)) {
        croak "Missing :name for COUNTER attribute";
    }

    my $getter = _extract_get($config)  || $name;
    my $setter = _extract_set($config)  || "set_$name";
    my $incr   = _extract_incr($config) || "incr_$name";
    my $decr   = _extract_decr($config) || "decr_$name";

    my $init_arg = _extract_init_arg($config) || $name;

    my $default = _extract_default($config) || 0;

    my $trace = _extract_trace($config) || 0;

    if (__nonempty($default)) {
        # if ($default !~ m{\A \s* -? \s* \d+ \z}smx) {
        #     croak "Illegal non-integral :default ($default) for COUNTER";
        # }
    } else {
        $default = 0;
    }

    my $spec = {
        name     => $name,
        ref      => $referent,
        type     => 'COUNTER',
        default  => $default,
        init_arg => $init_arg,
        package  => $package,
    };

    return $spec unless __nonempty($name);

    $attribute_by_name{ "${package}::${name}" } = $spec;

    if ($getter ne CUSTOM_ACCESSOR) {
        no strict 'refs';

        $spec->{getter} = *{ "${package}::${getter}" } = sub {
            my $self = shift;

            my $value = $referent->{ID($self)};

            if ($trace & TRACE_GET) {
                carp "*** GET: ${package}::${getter}() = '$value'";
            }

            return $value;
        };
    }

    if ($setter ne CUSTOM_ACCESSOR) {
        no strict 'refs';

        $spec->{setter} = *{ "${package}::${setter}" } = sub {
            croak "Missing new value in '$setter'" unless @_ == 2;

            my ($self, $new_val) = @_;

            if ($new_val !~ m{\A \s* -? \s* \d+ \z}smx) {
                croak "Illegal non-integral value '$new_val' in $setter";
            }

            if ($trace & TRACE_SET) {
                carp "*** SET: ${package}::${setter}() = '$new_val'";
            }

            $referent->{ID($self)} = $new_val;

            return;
        };
    }

    if ($incr ne CUSTOM_ACCESSOR) {
        no strict 'refs';

        $spec->{incr} = *{ "${package}::${incr}" } = sub {
            my $self = shift;

            # Similar code in $decr sometimes fails horribly, so let's
            # replace it here too for superstitious reasons.

            # my $new_val = ++$referent->{ID($self)};

            my $new_val = $referent->{ID($self)} + 1;

            if ($trace & TRACE_SET) {
                carp "*** INCR: ${package}::${setter}() = '$new_val'";
            }

            return $referent->{ID($self)} = $new_val;
        };
    }

    if ($decr ne CUSTOM_ACCESSOR) {
        no strict 'refs';

        $spec->{decr} = *{ "${package}::${decr}" } = sub {
            my $self = shift;

            ## WTF?  Why does this sometimes fail horribly?
            # my $new_val = --$referent->{ID($self)};

            my $new_val = $referent->{ID($self)} - 1;

            if ($trace & TRACE_SET) {
                carp "*** DECR: ${package}::${setter}() = '$new_val'";
            }

            return $referent->{ID($self)} = $new_val;
        };
    }

    return $spec;
}

sub __declare_ARRAY {
    my $package  = shift;
    my $referent = shift;
    my $config   = shift;

    $is_one_of_us{$package} = 1;

    my $name = _extract_name($config);

    if (__empty($name)) {
        croak "Missing :name for ARRAY attribute";
    }

    my $getarray  = _extract_getarray($config) || "get_${name}s";
    my $getsize   = _extract_numarray($config) || "num_${name}s";
    my $deleter   = _extract_deleter($config)  || "delete_${name}s";
    my $getter    = _extract_get($config)      || "get_$name";
    my $setter    = _extract_set($config)      || "set_$name";
    my $pop       = _extract_pop($config)      || "pop_$name";
    my $push      = _extract_push($config)     || "push_$name";
    my $shift     = _extract_shift($config)    || "shift_$name";
    my $unshift   = _extract_unshift($config)  || "unshift_$name";
    my $adder     = _extract_add($config)      || "add_$name";

    my $type = _extract_type($config) || '';

    my $trace = _extract_trace($config) || 0;

    my $default_value = _extract_default_val($config);

    if (__nonempty($default_value)) {
        $default_value = eval qq{ { package $package; $default_value; } };
    }

    my $spec = {
        name     => $name,
        ref      => $referent,
        type     => $type,
        is_array => 1,
        default  => _extract_default($config),
        init_arg => _extract_init_arg($config) || $name,
        package  => $package,
    };

    $attribute_by_name{ "${package}::${name}" } = $spec;

    if ($getarray ne CUSTOM_ACCESSOR) {
        no strict 'refs';

        $spec->{getarray} = *{ "${package}::${getarray}" } = sub {
            return protect_array_attribute($referent->{ID($_[0])});
        };
    }

    if ($getsize ne CUSTOM_ACCESSOR) {
        no strict 'refs';

        $spec->{getsize} = *{ "${package}::${getsize}" } = sub {
            return scalar @{ $referent->{ID($_[0])} };
        };
    }

    if ($deleter ne CUSTOM_ACCESSOR) {
        no strict 'refs';

        $spec->{deletearray} = *{ "${package}::$deleter" } = sub {
            if ($trace & TRACE_DELETE) {
                carp "*** DELETE: ${package}::${deleter}()";
            }

            my @values = @{ $referent->{ID($_[0])} };

            $referent->{ID($_[0])} = [];

            return @values;
        };
    }

    if ($getter ne CUSTOM_ACCESSOR) {
        no strict 'refs';

        $spec->{getter} = *{ "${package}::${getter}" } = sub {
            my $self  = shift;
            my $index = shift;

            if (! defined $index || $index =~ m{\a \d +\z}smx) {
                croak "Invalid index in ${package}::${getter}";
            }

            if (! exists $referent->{ID($self)}->[$index]) {
                if (defined $default_value) {
                    $referent->{ID($self)}->[$index] = $default_value;
                }
            }

            my $value = $referent->{ID($self)}->[$index];

            if ($trace & TRACE_GET) {
                carp "*** GET: ${package}::${getter}($index) = '$value'";
            }

            return $value;
        };
    }

    if ($setter ne CUSTOM_ACCESSOR) {
        no strict 'refs';

        if (__nonempty($type)) {
            *{ "${package}::${setter}" } = sub {
                croak "Missing index and/or new value in '$setter'"
                    unless @_ == 3;

                my ($self, $index, $new_val) = @_;

                if (! eval { $new_val->isa($type) }) {
                    croak "Incorrect value type in $setter";
                }

                if (! defined $index || $index =~ m{\a \d +\z}smx) {
                    croak "Invalid index in ${package}::${setter}";
                }

                if ($trace & TRACE_SET) {
                    carp "*** SET: ${package}::${setter}($index) = '$new_val'";
                }

                $referent->{ID($self)}->[$index] = $new_val;

                return;
            };
        } else {
            *{ "${package}::${setter}" } = sub {
                croak "Missing index and/or new value in '$setter'"
                    unless @_ == 3;

                my ($self, $index, $new_val) = @_;

                if (! defined $index || $index =~ m{\a \d +\z}smx) {
                    croak "Invalid index in ${package}::${setter}";
                }

                if ($trace & TRACE_SET) {
                    carp "*** SET: ${package}::${setter}($index) = '$new_val'";
                }

                $referent->{ID($self)}->[$index] = $new_val;

                return;
            };
        }
    }

    if ($pop ne CUSTOM_ACCESSOR) {
        no strict 'refs';

        $spec->{pop} = *{ "${package}::${pop}" } = sub {
            return pop @{ $referent->{ID($_[0])} };
        };
    }

    if ($push ne CUSTOM_ACCESSOR) {
        no strict 'refs';

        if (__nonempty($type)) {
            $spec->{pusher} = *{ "${package}::${push}" } = sub {
                my ($self, @new_vals) = @_;

                for my $new_val (@new_vals) {
                    if (! eval { $new_val->isa($type) }) {
                        croak "Incorrect value type in $push";
                    }
                }

                push @{ $referent->{ID($self)} }, @new_vals;

                return;
            };
        } else {
            $spec->{pusher} = *{ "${package}::${push}" } = sub {
                my ($self, @new_vals) = @_;

                push @{ $referent->{ID($self)} }, @new_vals;

                return;
            };
        }
    }

    if ($shift ne CUSTOM_ACCESSOR) {
        no strict 'refs';

        $spec->{shift} = *{ "${package}::${shift}" } = sub {
            return shift @{ $referent->{ID($_[0])} };
        };
    }

    if ($unshift ne CUSTOM_ACCESSOR) {
        no strict 'refs';

        if (__nonempty($type)) {
            $spec->{unshift} = *{ "${package}::${unshift}" } = sub {
                my ($self, @new_vals) = @_;

                for my $new_val (@new_vals) {
                    if (! eval { $new_val->isa($type) }) {
                        croak "Incorrect value type in $unshift";
                    }
                }

                unshift @{ $referent->{ID($self)} }, @new_vals;

                return;
            };
        } else {
            $spec->{unshift} = *{ "${package}::${unshift}" } = sub {
                my ($self, @new_vals) = @_;

                unshift @{ $referent->{ID($self)} }, @new_vals;

                return;
            };
        }
    }

    if ($adder ne CUSTOM_ACCESSOR) {
        no strict 'refs';

        if (__nonempty($type)) {
            $spec->{adder} = *{ "${package}::${adder}" } = sub {
                croak "Missing new value in '$adder'" unless @_ == 2;

                my ($self, $new_val) = @_;

                if (! eval { $new_val->isa($type) }) {
                    croak "Incorrect value type in add_$adder";
                }

                push @{ $referent->{ID($self)} }, $new_val;

                return;
            };
        } else {
            $spec->{adder} = *{ "${package}::${adder}" } = sub {
                croak "Missing new value in '$adder'" unless @_ == 2;

                my ($self, $new_val) = @_;

                push @{ $referent->{ID($self)} }, $new_val;

                return;
            };
        }
    }

    return $spec;
}

sub __declare_HASH {
    my $package  = shift;
    my $referent = shift;
    my $config   = shift;

    $is_one_of_us{$package} = 1;

    my $name = _extract_name($config);

    if (__empty($name)) {
        croak "Missing :name for HASH attribute";
    }

    my $getter   = _extract_get($config)      || "get_$name";
    my $setter   = _extract_set($config)      || "set_$name";
    my $gethash  = _extract_gethash($config)  || "get_${name}s";
    my $sethash  = _extract_sethash($config)  || "set_${name}s";
    my $deleter  = _extract_deletehash($config) || "delete_{$name}s";

    my $type = _extract_type($config) || '';

    my $trace = _extract_trace($config) || 0;

    my $spec = {
        name     => $name,
        ref      => $referent,
        type     => $type,
        is_hash  => 1,
        default  => _extract_default($config),
        init_arg => _extract_init_arg($config) || $name,
        package  => $package,
    };

    $attribute_by_name{ "${package}::${name}" } = $spec;

    if (__nonempty($name)) {
        my $deleter = "delete_${name}";

        no strict 'refs';

        $spec->{delete} = *{ "${package}::${deleter}" } = sub {
            if ($trace & TRACE_DELETE) {
                carp "*** DELETE: ${package}::${deleter}()";
            }

            my $values = $referent->{ID($_[0])};

            $referent->{ID($_[0])} = {};

            return $values;
        };
    }

    if ($deleter ne CUSTOM_ACCESSOR) {
        no strict 'refs';

        $spec->{deletehash} = *{ "${package}::$deleter" } = sub {
            if ($trace & TRACE_DELETE) {
                carp "*** DELETE: ${package}::${deleter}()";
            }

            my $hash = $referent->{ID($_[0])};

            $referent->{ID($_[0])} = {};

            return $hash;
        };
    }

    {
        no strict 'refs';

        $spec->{gethash} = *{ "${package}::${gethash}" } = sub {
            return protect_hash_attribute($referent->{ID($_[0])});
        };
    }

    if ($getter ne CUSTOM_ACCESSOR) {
        no strict 'refs';

        $spec->{getter} = *{ "${package}::${getter}" } = sub {
            my $self = shift;
            my $key  = shift;

            my $value = $referent->{ID($self)}->{$key};

            if ($trace & TRACE_GET) {
                carp "*** GET: ${package}::${getter}(\"$key\") = '$value'";
            }

            return $value;
        };
    }

    if ($setter ne CUSTOM_ACCESSOR) {
        no strict 'refs';

        $spec->{sethash} = *{ "${package}::${sethash}" } = sub {
            my ($self, $hash_ref) = @_;

            $referent->{ID($self)} = $hash_ref;

            return;
        };

        if (__nonempty($type)) {
            *{ "${package}::${setter}" } = sub {
                croak "Missing key and/or value in '$setter'"
                    unless @_ == 3;

                my ($self, $key, $value) = @_;

                if (! eval { $value->isa($type) }) {
                    croak "Incorrect value type in $setter";
                }

                if ($trace & TRACE_SET) {
                    carp "*** SET: ${package}::set_${name}(\"$key\") = '$value'";
                }

                $referent->{ID($self)}->{$key} = $value;

                return;
            };
        } else {
            *{ "${package}::${setter}" } = sub {
                croak "Missing index and/or value in '$setter'"
                    unless @_ == 3;

                my ($self, $key, $value) = @_;

                if (! defined $key) {
                    carp "Undefined key in ${package}::${setter}";
                }

                if ($trace & TRACE_SET) {
                    carp "*** SET: ${package}::set_${name}(\"$key\") = '$value'";
                }

                $referent->{ID($self)}->{$key} = $value;

                return;
            };
        }
    } elsif (__nonempty($type)) {
        carp "Ignoring :type<$type> specifier";
    }

    return $spec;
}

sub MODIFY_HASH_ATTRIBUTES {
    my ($package, $referent, @attrs) = @_;

    for my $attr (@attrs) {
        $attr =~ m{\A (\w+) \s* (?: \( (.*) \) )? \z}smx;

        my $type   = $1;
        my $config = $2;

        my $spec;

        local $Carp::CarpLevel = 1;

        if ($type =~ m{\A ATTRS?}smx) {
            $spec = __declare_ATTR($package, $referent, $config);
        }
        elsif ($type eq 'ARRAY') {
            $spec = __declare_ARRAY($package, $referent, $config);
        }
        elsif ($type eq 'HASH') {
            $spec = __declare_HASH($package, $referent, $config);
        }
        elsif ($type eq 'BOOLEAN') {
            $spec = __declare_BOOLEAN($package, $referent, $config);
        }
        elsif ($type eq 'COUNTER' || $type eq 'INT') {
            $spec = __declare_COUNTER($package, $referent, $config);
        }
        else {
            next;
        }

        undef $attr;

        push @{ $attribute{$package} }, $spec;
    }

    return grep { defined } @attrs;
}

## protect_array_attribute() solves two different problems.

## FIRST, suppose that had the following object:
##
##     {
##         package Article;
##
##         use Class::Std;
##
##         my %authors_of :ATTR;
##
##         sub BUILD {
##             ...
##
##             $authors_of{$ident} = [];
##
##             ...
##         }
##     }
##
## and get_authors() were defined as
##
##     sub get_authors { return $authors_of{...} }
##
## Then, for example, the following code
##
##     my $authors = $article->get_authors();
##
##     while (my $author = shift @{ $authors }) { ... }
##
## would result in $article's author list being emptied out.  To avoid
## this rather severe violation of data encapsulation, we arrange to
## return a reference to a copy of the list.  (The objects in the list
## can still be modified via their accessors, but that's ok.)
##
## Incidentally,
##
##     return \@{ $authors_of{...} }
##
## does *not* return a reference to a copy of the list.  Apparently
## perl is "smart" enough to optimize the copy away.

## SECOND, we'd like to be able to write
##
##     my @authors = $article->get_authors();
##
## instead of
##
##     my @authors = @{ $article->get_authors() };
##
## Unfortunately, the Perl Template Toolkit wants array references,
## not arrays, returned in contexts such as
##
##     [% authors = article.get_authors %]
##
## but -- and here's the kicker -- IT ALWAYS INVOKES THE METHOD IN
## LIST CONTEXT.  This means that the obvious trick of
##
##     return wantarray @array : \@array;
##
## fails when invoked from within the PTT.  So, we check who's calling
## the accessor and, if it appears to be the PTT, we always return an
## array reference.

sub protect_array_attribute {
    my $aref = shift;

    my @array = $aref->@*;

    # caller(0) = protect_array_attribute()
    # caller(1) = accessor, e.g. get_authors()
    # caller(2) = code invoking accessor

    my $context = caller(2);

    if (defined $context && $context =~ m{^Template::(Document|Stash)}) {
        return \@array;
    }

    return wantarray ? @array : \@array;
}

sub protect_hash_attribute {
    my $href = shift;

    my %hash = %{ $href || {} };

    # caller(0) = protect_hash_attribute()
    # caller(1) = accessor, e.g. get_authors()
    # caller(2) = code invoking accessor

    my $context = caller(2);

    if (defined $context && $context =~ m{^Template::(Document|Stash)}) {
        return \%hash;
    }

    return wantarray ? %hash : \%hash;
}

sub _DUMP {
    my $self = shift;

    my $id = ID($self);

    my %dump;

    for my $package (keys %attribute) {
        my $attr_list_ref = $attribute{$package};

        for my $attr_ref ( $attr_list_ref->@* ) {
            next unless exists $attr_ref->{ref}{$id};

            $dump{$package}{$attr_ref->{name}} = $attr_ref->{ref}{$id};
        }
    }

    require Data::Dumper;

    my $dump = Data::Dumper::Dumper(\%dump);

    $dump =~ s/^.{8}//gxms;

    return $dump;
}

my $STD_OVERLOADER
    = q{ package %%s;
         use overload (
            q{%s} => sub { $_[0]->%%s($_[0]->ident()) },
            fallback => 1
         );
       };

my %OVERLOADER_FOR = (
    STRINGIFY => sprintf( $STD_OVERLOADER, q{""}   ),
    NUMERIFY  => sprintf( $STD_OVERLOADER, q{0+}   ),
    BOOLIFY   => sprintf( $STD_OVERLOADER, q{bool} ),
    SCALARIFY => sprintf( $STD_OVERLOADER, q{${}}  ),
    ARRAYIFY  => sprintf( $STD_OVERLOADER, q{@{}}  ),
    HASHIFY   => sprintf( $STD_OVERLOADER, q{%%{}} ),  # %% to survive sprintf
    GLOBIFY   => sprintf( $STD_OVERLOADER, q{*{}}  ),
    CODIFY    => sprintf( $STD_OVERLOADER, q{&{}}  ),
);

sub MODIFY_CODE_ATTRIBUTES {
    my ($package, $referent, @attrs) = @_;

    for my $attr (@attrs) {
        if ($attr eq 'CUMULATIVE') {
            push $cumulative{$package}->@*, $referent;
        }
        elsif ($attr =~ m/\A CUMULATIVE \s* [(] \s* BASE \s* FIRST \s* [)] \z/xms) {
            push $anticumulative{$package}->@*, $referent;
        }
        elsif ($attr =~ m/\A RESTRICTED \z/xms) {
            push $restricted{$package}->@*, $referent;
        }
        elsif ($attr =~ m/\A PRIVATE \z/xms) {
            push $private{$package}->@*, $referent;
        }
        elsif (exists $OVERLOADER_FOR{$attr}) {
            push $overload{$package}->@*, [$referent, $attr];
        }

        undef $attr;
    }

    return grep { defined } @attrs;
}

my %_hierarchy_of;

sub _hierarchy_of {
    my $class = shift;

    return $_hierarchy_of{$class}->@* if exists $_hierarchy_of{$class};

    no strict 'refs';

    my @hierarchy = $class;
    my @parents   = "${class}::ISA"->@*;

    while (defined (my $parent = shift @parents)) {
        push @hierarchy, $parent;

        push @parents, "${parent}::ISA"->@*;
    }

    my %seen;

    return $_hierarchy_of{$class}->@*
        = sort { $a->isa($b) ? -1
               : $b->isa($a) ? +1
               :                0
               } grep !$seen{$_}++, @hierarchy;
}

my %_reverse_hierarchy_of;

sub _reverse_hierarchy_of {
    my $class = shift;

    return $_reverse_hierarchy_of{$class}->@*
        if exists $_reverse_hierarchy_of{$class};

    no strict 'refs';

    my @hierarchy = $class;
    my @parents   = reverse "${class}::ISA"->@*;

    while (defined (my $parent = shift @parents)) {
        push @hierarchy, $parent;

        push @parents, reverse "${parent}::ISA"->@*;
    }

    my %seen;
    return $_reverse_hierarchy_of{$class}->@*
        = reverse sort { $a->isa($b) ? -1
                       : $b->isa($a) ? +1
                       :                0
                       } grep !$seen{$_}++, @hierarchy;
}

{
    no warnings qw( void );

    CHECK { initialize() }
}

sub __find_sub {
    my ($package, $sub_ref) = @_;

    no strict 'refs';

    for my $name (keys "${package}::"->%*) {
        my $candidate = *{ "${package}::$name" }{CODE};

        return $name if $candidate && $candidate == $sub_ref;
    }

    croak q{Can't make anonymous subroutine cumulative};
}

## Originally these two hashes were declared within the body of
## initialize(), meaning that closures were used by the definitions of
## cumulative and anticumulative methods.  For some reason, that
## didn't always work: entries in %anticumulative_named would get lost
## by the time the method was called.  Making them package lexicals
## seems to have fixed that.

my (%cumulative_named, %anticumulative_named);

sub initialize {
    # Short-circuit if nothing to do...
    return if keys(%restricted) + keys(%private)
            + keys(%cumulative) + keys(%anticumulative)
            + keys(%overload)
                == 0;

    # :RESTRICTED methods (only callable within hierarchy)...

    for my $package (keys %restricted) {
        for my $sub_ref ( $restricted{$package}->@*) {
            my $name = __find_sub($package, $sub_ref);

            no warnings 'redefine';
            no strict 'refs';

            my $sub_name = "${package}::$name";

            my $original = *{ $sub_name }{CODE}
                or croak "Restricted method ${package}::$name() declared ",
                         'but not defined';

            *{ $sub_name } = sub {
                my $caller;

                my $level = 0;

                while ($caller = caller($level++)) {
                     last if $caller !~ /^(?: TeX::Class | attributes )$/xms;
                }

                goto &{ $original } if !$caller || $caller->isa($package)
                                                || $package->isa($caller);

                croak "Can't call restricted method $sub_name() from class $caller";
            }
        }
    }

    # :PRIVATE methods (only callable from class itself)...

    for my $package (keys %private) {
        for my $sub_ref ($private{$package}->@*) {
            my $name = __find_sub($package, $sub_ref);

            no warnings 'redefine';
            no strict 'refs';

            my $sub_name = "${package}::$name";

            my $original = *{ $sub_name }{CODE}
                or croak "Private method ${package}::$name() declared ",
                         'but not defined';

            *{ $sub_name } = sub {
                my $caller = caller;

                goto &{ $original } if $caller eq $package;

                croak "Can't call private method $sub_name() from class $caller";
            }
        }
    }

    # :CUMULATIVE methods

    for my $package (keys %cumulative) {
        for my $sub_ref ($cumulative{$package}-@*) {
            my $name = __find_sub($package, $sub_ref);

            $cumulative_named{$name}{$package} = $sub_ref;

            no warnings 'redefine';
            no strict 'refs';

            *{ "${package}::$name" } = sub {
                my @args = @_;

                my $class = ref($_[0]) || $_[0];

                my $list_context = wantarray;

                my (@results, @classes);

                for my $parent (_hierarchy_of($class)) {
                    my $sub_ref = $cumulative_named{$name}{$parent} or next;

                    ${ "${parent}::AUTOLOAD" } = our $AUTOLOAD if $name eq 'AUTOLOAD';

                    if (! defined $list_context) {
                        $sub_ref->(@args);

                        next;
                    }

                    push @classes, $parent;

                    if ($list_context) {
                        push @results, $sub_ref->(@args);
                    }
                    else {
                        push @results, scalar $sub_ref->(@args);
                    }
                }

                return unless defined $list_context;

                return @results if $list_context;

                return TeX::Class::SCR->new({
                    values  => \@results,
                    classes => \@classes,
                });
            };
        }
    }

    # :CUMULATIVE(BASE FIRST) (aka anticumulative) methods

    for my $package (keys %anticumulative) {
        for my $sub_ref ($anticumulative{$package}->@*) {
            my $name = __find_sub($package, $sub_ref);

            if ($cumulative_named{$name}) {
                for my $other_package (keys $cumulative_named{$name}->%*) {
                    next unless $other_package->isa($package)
                             || $package->isa($other_package);

                    print STDERR
                        "Conflicting definitions for cumulative method",
                        " '$name'\n",
                        "(specified as :CUMULATIVE in class '$other_package'\n",
                        " but declared :CUMULATIVE(BASE FIRST) in class ",
                        " '$package')\n";

                    exit(1);
                }
            }

            $anticumulative_named{$name}{$package} = $sub_ref;

            no warnings 'redefine';
            no strict 'refs';

            *{ "${package}::$name" } = sub {
                my @args = @_;

                my $class = ref($_[0]) || $_[0];

                my $list_context = wantarray;

                my (@results, @classes);

                for my $parent (_reverse_hierarchy_of($class)) {
                    my $sub_ref = $anticumulative_named{$name}{$parent} or next;

                    if (! defined $list_context) {
                        $sub_ref->(@args);

                        next;
                    }

                    push @classes, $parent;

                    if ($list_context) {
                        push @results, $sub_ref->(@args);
                    }
                    else {
                        push @results, scalar $sub_ref->(@args);
                    }
                }

                return if ! defined $list_context;

                return @results if $list_context;

                return TeX::Class::SCR->new({
                    values  => \@results,
                    classes => \@classes,
                });
            };
        }
    }

    # OVERLOAD methods

    for my $package (keys %overload) {
        foreach my $operation ($overload{$package}->@*) {
            my ($referent, $attr) = $operation->@*;

            local $^W;

            my $method = __find_sub($package, $referent);

            eval sprintf $OVERLOADER_FOR{$attr}, $package, $method;

            die "Internal error: $@" if $@;
        }
    }

    # Remove initialization data to prevent re-initializations...

    %restricted     = ();
    %private        = ();
    %cumulative     = ();
    %anticumulative = ();
    %overload       = ();

    return;
}

my sub uniq {
    my %seen;

    return grep { $seen{$_}++ } @_;
}

my sub _mislabelled {
    my (@names) = map { qq{'$_'} } uniq @_;

    return q{} if @names == 0;

    my $arglist
        = @names == 1 ? $names[0]
        : @names == 2 ? join q{ or }, @names
        :               join(q{, }, @names[0..$#names-1]) . ", or $names[-1]"
        ;
    return "(Did you mislabel one of the args you passed: $arglist?)\n";
}

sub new {
    my ($class, $arg_ref) = @_;

    # Ensure run-time (and mod_perl) setup is done
    TeX::Class::initialize();

    no strict 'refs';

    croak "Can't find class $class" if ! keys "${class}::"->%*;

    croak "Argument to $class->new() must be hash reference"
        if @_ > 1 && ref $arg_ref ne 'HASH';

    my $new_obj = bless \my($anon_scalar), $class;
    my $new_obj_id = ID($new_obj);

    my (@missing_inits, @suss_keys);

    $arg_ref ||= {};

    my $supply_defaults = $arg_ref->{SUPPLY_DEFAULTS};

    my %arg_set;

  BUILD:
    for my $base_class (_reverse_hierarchy_of($class)) {
        my $arg_set = $arg_set{$base_class}
                    = { %{ $arg_ref }, %{ $arg_ref->{$base_class} || {} } };

        # Apply BUILD() methods...
        {
            no warnings 'once';

            if (my $build_ref = *{ "${base_class}::BUILD" }{CODE}) {
                $build_ref->($new_obj, $new_obj_id, $arg_set);
            }
        }

        # Apply init_arg and default for attributes still undefined...

      INITIALIZATION:
        for my $attr_ref ( $attribute{$base_class}->@* ) {
            next INITIALIZATION if defined $attr_ref->{ref}{$new_obj_id};

            my $lvalue = \$attr_ref->{ref}{$new_obj_id};

            if (defined $attr_ref->{init_arg}
                && exists $arg_set->{$attr_ref->{init_arg}}) {

                my $init_arg = $attr_ref->{init_arg};
                my $init_val = $arg_set->{$init_arg};

                if (defined(my $setter= $attr_ref->{setter})) {
                    $new_obj->$setter($init_val);
                } elsif (defined(my $adder= $attr_ref->{adder})) {
                    $new_obj->$adder($init_val);
                } else {
                    $lvalue->$* = $init_val;
                }

                next INITIALIZATION;
            }
            elsif (defined $attr_ref->{default}) {
                # Or use default value specified...

                my $package = $attr_ref->{package};

                my $default_value = eval qq{
                    { package $package;
                      return $attr_ref->{default};
                    }
                };

                ## If I've thought this through correctly, there's no
                ## need for the above to fail unless the :default
                ## specifier really is bogus. [dmj]

                if ($@) {
                    (my $error = $@) =~ s/ at .* line .*\n?$//;

                    croak "Can't interpret default value for $attr_ref->{name}: '$error'";
                }

                my $setter = $attr_ref->{setter};

                if (defined $setter) {
                    $new_obj->$setter($default_value);
                } else {
                    $lvalue->$* = $default_value;
                }

                next INITIALIZATION;
            }
            elsif ($attr_ref->{is_array}) {
                $lvalue->$* = [];

                next INITIALIZATION;
            }
            elsif ($attr_ref->{is_hash}) {
                $lvalue->$* = {};

                next INITIALIZATION;
            }
            else {
                my $type = $attr_ref->{type};

                if ($supply_defaults && __nonempty($type)) {
                    if ($is_one_of_us{$type}) {
                        $lvalue->$* = $type->new({ SUPPLY_DEFAULTS => 1 });
                    } elsif (eval { $type->can("new") }) {
                        $lvalue->$* = $type->new();
                    }
                }
            }

            ## I hate having to specify a :default just because I used
            ## a :name.  Or because I specified an :init_arg, for that
            ## matter.

            # if (defined $attr_ref->{init_arg}) {
            #     # Record missing init_arg...
            #     push @missing_inits,
            #          "Missing initializer label for $base_class: "
            #          . "'$attr_ref->{init_arg}'.\n";
            #     push @suss_keys, keys %{$arg_set};
            # }
        }
    }

    croak @missing_inits, _mislabelled(@suss_keys),
          'Fatal error in constructor call'
                if @missing_inits;

    # START methods run after all BUILD methods complete...
    for my $base_class (_reverse_hierarchy_of($class)) {
        my $arg_set = $arg_set{$base_class};

        # Apply START() methods...
        {
            no warnings 'once';
            if (my $init_ref = *{ "${base_class}::START" }{CODE}) {
                $init_ref->($new_obj, $new_obj_id, $arg_set);
            }
        }
    }

    return $new_obj;
}

## This needs to be thoroughly tested.

sub clone {
    my $orig = shift;

    my $class = ref($orig) or croak "Can't clone a non-object: $orig";

    my $orig_id = ID($orig);

    my $clone = bless \my($anon_scalar), $class;
    my $clone_id = ID($clone);

    no strict 'refs';

    croak "Can't find class $class" if ! keys %{ $class.'::' };

    my (@missing_inits, @suss_keys);

  CLONE:
    for my $base_class (_reverse_hierarchy_of($class)) {

      INITIALIZATION:
        for my $attr_ref ( $attribute{$base_class}->@* ) {

            my $rvalue = $attr_ref->{ref}{$orig_id};

            my @clones = __clone_values($rvalue);

            $attr_ref->{ref}{$clone_id} = $clones[0];
        }
    }

    return $clone;
}

sub __clone_values;

sub __clone_values {
    my @values = @_;

    my @clones;

    for my $value (@values) {
        my $type = ref($value);

        if (! $type) {
            push @clones, $value;

            next;
        }

        if ($is_one_of_us{$type}) {
            push @clones, $value->clone();

            next;
        }

        if (eval { $type->can("clone") }) {
            push @clones, $value->clone();

            next;
        }

        if ($type eq 'ARRAY') {
            push @clones, [ __clone_values( @{ $value } ) ];

            next;
        }

        if ($type eq 'HASH') {
            my %new;

            while (my ($key, $val) = each $value->%*) {
                $new{$key} = (__clone_values($val))[0];
            }

            push @clones, \%new;

            next;
        }

        # if ($type eq 'REF') {
        #     ## ???
        #
        #     next;
        # }

        ## Otherwise just copy it.

        push @clones, $value;

    }

    return @clones;
}

######################################################################
##                                                                  ##
##               GENERIC ACCESSORS AND INTROSPECTION                ##
##                                                                  ##
######################################################################

sub type_of {
    my $self = shift;

    my $field_name = shift;

    my $class = ref($self);

    for my $package (_hierarchy_of($class)) {
        my $attr_spec = $attribute_by_name{ "${package}::${field_name}" };

        return $attr_spec->{type} if defined $attr_spec;
    }

    croak "Unknown field '$field_name' in type_of for $class";
}

sub is_array {
    my $self = shift;

    my $field_name = shift;

    my $class = ref($self);

    for my $package (_hierarchy_of($class)) {
        my $attr_spec = $attribute_by_name{ "${package}::${field_name}" };

        return $attr_spec->{is_array} if defined $attr_spec;
    }

    croak "Unknown field '$field_name' in is_array for $class";
}

sub is_hash {
    my $self = shift;

    my $field_name = shift;

    my $class = ref($self);

    for my $package (_hierarchy_of($class)) {
        my $attr_spec = $attribute_by_name{ "${package}::${field_name}" };

        return $attr_spec->{is_hash} if defined $attr_spec;
    }

    croak "Unknown field '$field_name' in is_hash for $class";
}

sub get {
    my $self = shift;

    my $field_name = shift;

    croak "Missing field name in 'get'" if __empty($field_name);

    my $class = ref($self);

    for my $package (_hierarchy_of($class)) {
        my $attr_spec = $attribute_by_name{ "${package}::${field_name}" };

        next unless defined $attr_spec;

        my $getter = $attr_spec->{getter};

        if ($attr_spec->{is_array} && @_) {
            $getter = $attr_spec->{getarray};
        }

        if (! defined $getter) {
            croak "Can't determine getter for field '$field_name' in get for $package";
        }

        return $self->$getter();
    }

    croak "Unknown field '$field_name' in get for $class";
}

sub set {
    my $self = shift;

    croak "Missing field value and/or new value in 'set'" unless @_ >= 2;

    my $field_name = shift;

    my $class = ref($self);

    for my $package (_hierarchy_of($class)) {
        my $attr_spec = $attribute_by_name{ "${package}::${field_name}" };

        next unless defined $attr_spec;

        my $setter = $attr_spec->{setter};

        if (! defined $setter) {
            $setter = $attr_spec->{adder};

            if (! defined $setter) {
                croak "Can't determine setter for field '$field_name' in get for $package";
            }
        }

        return $self->$setter(@_);
    }

    croak "Unknown field '$field_name' in set for $class";
}

sub add {
    my $self = shift;

    croak "Missing field value and/or new value in 'add'" unless @_ >= 2;

    my $field_name = shift;

    my $class = ref($self);

    for my $package (_hierarchy_of($class)) {
        my $attr_spec = $attribute_by_name{ "${package}::${field_name}" };

        next unless defined $attr_spec;

        if (! $attr_spec->{is_array}) {
            croak "Can't use add() on non-array attribute '$field_name' for $package";
        }

        my $adder = $attr_spec->{adder};

        if (! defined $adder) {
            croak "Can't determine adder for field '$field_name' in get for $package";
        }

        return $self->$adder(@_);
    }

    croak "Unknown field '$field_name' in get for $class";
}

sub hash_keys {
    my $self = shift;

    my $field_name = shift;

    croak "Missing field name in 'keys'" if __empty($field_name);

    my $class = ref($self);

    for my $package (_hierarchy_of($class)) {
        my $attr_spec = $attribute_by_name{ "${package}::${field_name}" };

        next unless defined $attr_spec;

        if (! $attr_spec->{is_hash}) {
            croak "Can't use 'keys' on non-hash attribute '$field_name' in $package";
        }

        my $referent = $attr_spec->{ref};

        return keys %{ $referent->{ID($self)} };
    }

    croak "Unknown field '$field_name' in keys for $class";
}

sub DESTROY {
    my ($self) = @_;

    my $id = ID($self);

    push @_, $id;

    for my $base_class (_hierarchy_of(ref $_[0])) {
        no strict 'refs';
        no warnings 'once';

        if (my $demolish_ref = *{ "${base_class}::DEMOLISH" }{CODE}) {
            &{ $demolish_ref };
        }

        for my $attr_ref ( $attribute{$base_class}->@* ) {
            delete $attr_ref->{ref}{$id};
        }
    }
}

sub AUTOLOAD {
    my ($invocant) = @_;

    my $invocant_class = ref $invocant || $invocant;

    my ($package_name, $method_name) = our $AUTOLOAD =~ m/ (.*) :: (.*) /xms;

    my $ident = ID($invocant) // $invocant;

    for my $parent_class ( _hierarchy_of($invocant_class) ) {
        no strict 'refs';

        if (my $automethod_ref = *{ "${parent_class}::AUTOMETHOD" }{CODE}) {
            local $CALLER::_ = $_;

            local $_ = $method_name;

            if (my $method_impl
                    = $automethod_ref->($invocant, $ident, @_[1..$#_])) {
                goto &$method_impl;
            }
        }
    }

    my $type = ref $invocant ? 'object' : 'class';

    croak qq{Can't locate $type method "$method_name" via package "$package_name"};
}

{
    my $real_can = \&UNIVERSAL::can;

    no warnings 'redefine', 'once';

    *UNIVERSAL::can = sub {
        my ($invocant, $method_name) = @_;

#print STDERR qq{*** invocant = '$invocant'; method_name = '$method_name'\n};

        if ( defined $invocant ) {
            if (my $sub_ref = $real_can->(@_)) {
                return $sub_ref;
            }

            my $invocant_class = ref($invocant) || $invocant;

            if ($is_one_of_us{$invocant_class}) {
                for my $parent_class ( _hierarchy_of($invocant_class) ) {
                    no strict 'refs';

                    if (my $automethod_ref = *{ "${parent_class}::AUTOMETHOD" }{CODE}) {
                        local $CALLER::_ = $_;

                        local $_ = $method_name;

                        if (my $method_impl = $automethod_ref->(@_)) {
                            return sub { my $inv = shift; $inv->$method_name(@_) }
                        }
                    }
                }
            }
        }

        return;
    };
}

## We haven't changed the implementation of this subclass, but
## importing Class::Std just to get access to Class::Std::SCR would be
## problematic.

package TeX::Class::SCR {
    use base qw(TeX::Class);

    BEGIN { *ID = \&Scalar::Util::refaddr; }

    my %values_of  : ATTR( :init_arg<values> );
    my %classes_of : ATTR( :init_arg<classes> );

    sub new {
        my ($class, $opt_ref) = @_;

        my $new_obj = bless \do{my $scalar}, $class;

        my $new_obj_id = ID($new_obj);

        $values_of{$new_obj_id}  = $opt_ref->{values};

        $classes_of{$new_obj_id} = $opt_ref->{classes};

        return $new_obj;
    }

    use overload (
        q{""}  => sub { return join q{}, grep { defined $_ } @{$values_of{ID($_[0])}}; },
        q{0+}  => sub { return scalar @{$values_of{ID($_[0])}};    },
        q{@{}} => sub { return $values_of{ID($_[0])};              },
        q{%{}} => sub {
            my ($self) = @_;
            my %hash;

            @hash{ $classes_of{ID($self)}->@* } = $values_of{ID($self)}->@*;

            return \%hash;
        },
        fallback => 1,
        );
}

1;

__END__
