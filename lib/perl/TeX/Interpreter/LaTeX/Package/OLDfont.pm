package TeX::Interpreter::LaTeX::Package::OLDfont;

# Copyright (C) 2022, 2024 American Mathematical Society
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

use strict;
use warnings;

use TeX::Token qw(:catcodes :factories);

use TeX::Utils::Misc;

use TeX::Node::CharNode qw(new_character);

use TeX::Constants qw(:save_stack_codes :token_types);

sub install ( $ ) {
    my $class = shift;

    my $tex = shift;

    $tex->package_load_notification();

    $tex->read_package_data();

    $tex->define_csname(em => make_font_declaration("italic"));
    $tex->define_csname(it => make_font_declaration("italic"));
    $tex->define_csname(bf => make_font_declaration("bold"));
    $tex->define_csname(sc => make_font_declaration("sc"));
    $tex->define_csname(rm => make_font_declaration("roman"));
    $tex->define_csname(tt => make_font_declaration("monospace", undef, 'OT1tt'));
    $tex->define_csname(sf => make_font_declaration("sans-serif"));

    $tex->define_csname(sl => make_font_declaration("styled-content", "oblique") );

    return;
}

use constant RIGHT_BRACE_TOKEN => make_character_token("}", CATCODE_LETTER);
use constant RIGHT_BRACE_CHAR  => new_character(ord("}"));

sub make_font_declaration {
    my $qName = shift;
    my $style = shift;
    my $encoding = shift;

    return sub {
        my $tex   = shift;
        my $token = shift;

        my $cur_group = $tex->cur_group();

        my $name = $token->get_csname();

        if (defined $encoding) {
            $tex->set_encoding($encoding);
        }

        if ($tex->is_mmode()) {
            my $csname = "math" . ($name eq 'em' ? "it" : $name);

            my $begin = $tex->tokenize("\\string\\${csname}\\string{");

            $tex->begin_token_list($begin, macro);

            if ($cur_group == math_shift_group) { # $\rm x$
                $tex->set_node_register(end_math_list => RIGHT_BRACE_CHAR);
            }
            elsif ($cur_group == math_left_group) { # $\left(\rm b\right)$
                $tex->set_node_register(end_math_list => RIGHT_BRACE_CHAR);
            }
            else {
                $tex->save_for_after(RIGHT_BRACE_TOKEN);
            }
        } else {
            if ($cur_group != simple_group) {
                my $file_name = $tex->get_file_name() || '<undef>';
                my $line_no   = $tex->input_line_no() || '<undef>';

                $tex->print_err("Ignoring improper \\$name at $file_name l. $line_no");
                $tex->error();

                return;
            }

            $tex->leavevmode();

            my $start = qq{\\startinlineXMLelement{$qName}};

            if ($name eq 'em') {
                $start .= qq{\\setXMLattribute{toggle}{yes}};
            } elsif (nonempty($style)) {
                $start .= qq{\\setXMLattribute{style-type}{$style}};
            }

            my $begin = $tex->tokenize($start);

            $tex->begin_token_list($begin, macro);

            my $end = sub { $tex->end_xml_element($qName) };

            $tex->save_for_after(make_anonymous_token($end));
        }

        return;
    };
}

1;

__DATA__

\ProvidesPackage{OLDfont}

%% ??? The \ifvmode version can't have worked if there were multiple
%% paragraphs in the scope of the font command.

\def\startinlineXMLelement#1{%
    % \ifvmode
    %     \everypar{\startXMLelement{#1}}%
    % \else
        \leavevmode
        \startXMLelement{#1}%
    % \fi
}

\endinput

__END__
