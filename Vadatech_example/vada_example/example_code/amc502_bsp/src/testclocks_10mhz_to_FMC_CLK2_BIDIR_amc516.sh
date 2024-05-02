#!/bin/bash

echo "10MHz Test Clock to FMC CLK2_BIDIR Setup..."
echo

amc516_clocktool cbsport tclka input term noinv tclka
amc516_clocktool cbsport tclkb output term noinv pllclka_out
amc516_clocktool cbsport tclkc output term noinv pllclkc_out
amc516_clocktool cbsport tclkd output term noinv pllclkb_out
amc516_clocktool cbsport pllclka output term noinv tclka
amc516_clocktool cbsport pllclkb output term noinv tclka
amc516_clocktool cbsport pllclkc output term noinv tclka
amc516_clocktool cbsport pllclkd output term noinv tclka
amc516_clocktool cbsport pllclka_out input term noinv tclka
amc516_clocktool cbsport pllclkb_out input term noinv tclka
amc516_clocktool cbsport pllclkc_out input term noinv tclka
amc516_clocktool cbsport pllclkd_out input term noinv tclka
amc516_clocktool cbsport fmc_clk0_m2c input term noinv tclka
amc516_clocktool cbsport fmc_clk1_m2c input term noinv tclka
amc516_clocktool cbsport fmc_clk2_bidir output term noinv pllclka_out
# To fmc_clk3_bidir: not connected
amc516_clocktool cbsport fmc_clk3_bidir output term noinv tclka
amc516_clocktool plltestsetup

echo "Expect 10MHz on LMK04828 CLKIN0 input"
echo
