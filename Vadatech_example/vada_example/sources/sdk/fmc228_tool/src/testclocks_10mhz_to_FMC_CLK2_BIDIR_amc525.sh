#!/bin/bash

echo "10MHz Test Clock to FMC CLK2_BIDIR Setup..."
echo

amc525_clocktool cbsport 1 fmcexpa output term noinv pllclka_out
amc525_clocktool cbsport 1 fmcexpb output term noinv pllclkb_out
amc525_clocktool cbsport 1 fmcexpc output term noinv pllclkc_out
amc525_clocktool cbsport 1 fmcexpd output term noinv pllclkb_out
amc525_clocktool cbsport 1 pllclka_out input term noinv fmcexpa
amc525_clocktool cbsport 1 pllclkb_out input term noinv fmcexpa
amc525_clocktool cbsport 1 pllclkc_out input term noinv fmcexpa
amc525_clocktool cbsport 1 pllclkd_out input term noinv fmcexpa
amc525_clocktool cbsport 1 fmc_clk0_m2c/0 input term noinv fmcexpa
amc525_clocktool cbsport 1 fmc_clk1_m2c/0 input term noinv fmcexpa
amc525_clocktool cbsport 1 fmc_clk2_bidir/0 output term noinv pllclka_out
# To fmc_clk3_bidir: not connected
amc525_clocktool cbsport 1 fmc_clk3_bidir/0 output term noinv pllclka_out
amc525_clocktool cbsport 1 fmc_clk0_m2c/1 input term noinv fmcexpa
amc525_clocktool cbsport 1 fmc_clk1_m2c/1 input term noinv fmcexpa
amc525_clocktool cbsport 1 fmc_clk2_bidir/1 output term noinv pllclka_out
# To fmc_clk3_bidir: not connected
amc525_clocktool cbsport 1 fmc_clk3_bidir/1 output term noinv pllclka_out
amc525_clocktool plltestsetup

echo "Expect 10MHz on both FMC's FMC_CLK2_BIDIR input"
echo
