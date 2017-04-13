---------------------------------------------------------------------------------------
-- Title          : Wishbone slave core for WR Softcore PLL
---------------------------------------------------------------------------------------
-- File           : spll_wbgen2_pkg.vhd
-- Author         : auto-generated by wbgen2 from spll_wb_slave.wb
-- Created        : Mon Sep 28 16:16:21 2015
-- Standard       : VHDL'87
---------------------------------------------------------------------------------------
-- THIS FILE WAS GENERATED BY wbgen2 FROM SOURCE FILE spll_wb_slave.wb
-- DO NOT HAND-EDIT UNLESS IT'S ABSOLUTELY NECESSARY!
---------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.wbgen2_pkg.all;

package spll_wbgen2_pkg is
  
  
  -- Input registers (user design -> WB slave)
  
  type t_spll_in_registers is record
    csr_n_ref_i                              : std_logic_vector(5 downto 0);
    csr_n_out_i                              : std_logic_vector(2 downto 0);
    csr_dbg_supported_i                      : std_logic;
    eccr_ext_supported_i                     : std_logic;
    eccr_ext_ref_present_i                   : std_logic;
    al_cr_valid_i                            : std_logic_vector(8 downto 0);
    al_cr_required_i                         : std_logic_vector(8 downto 0);
    al_cref_i                                : std_logic_vector(31 downto 0);
    al_cin_i                                 : std_logic_vector(31 downto 0);
    f_dmtd_freq_i                            : std_logic_vector(27 downto 0);
    f_dmtd_valid_i                           : std_logic;
    f_ref_freq_i                             : std_logic_vector(27 downto 0);
    f_ref_valid_i                            : std_logic;
    f_ext_freq_i                             : std_logic_vector(27 downto 0);
    f_ext_valid_i                            : std_logic;
    occr_out_en_i                            : std_logic_vector(7 downto 0);
    rcer_i                                   : std_logic_vector(31 downto 0);
    ocer_i                                   : std_logic_vector(7 downto 0);
    dfr_host_wr_req_i                        : std_logic;
    dfr_host_value_i                         : std_logic_vector(31 downto 0);
    dfr_host_seq_id_i                        : std_logic_vector(15 downto 0);
    trr_wr_req_i                             : std_logic;
    trr_value_i                              : std_logic_vector(23 downto 0);
    trr_chan_id_i                            : std_logic_vector(6 downto 0);
    trr_disc_i                               : std_logic;
    end record;
  
  constant c_spll_in_registers_init_value: t_spll_in_registers := (
    csr_n_ref_i => (others => '0'),
    csr_n_out_i => (others => '0'),
    csr_dbg_supported_i => '0',
    eccr_ext_supported_i => '0',
    eccr_ext_ref_present_i => '0',
    al_cr_valid_i => (others => '0'),
    al_cr_required_i => (others => '0'),
    al_cref_i => (others => '0'),
    al_cin_i => (others => '0'),
    f_dmtd_freq_i => (others => '0'),
    f_dmtd_valid_i => '0',
    f_ref_freq_i => (others => '0'),
    f_ref_valid_i => '0',
    f_ext_freq_i => (others => '0'),
    f_ext_valid_i => '0',
    occr_out_en_i => (others => '0'),
    rcer_i => (others => '0'),
    ocer_i => (others => '0'),
    dfr_host_wr_req_i => '0',
    dfr_host_value_i => (others => '0'),
    dfr_host_seq_id_i => (others => '0'),
    trr_wr_req_i => '0',
    trr_value_i => (others => '0'),
    trr_chan_id_i => (others => '0'),
    trr_disc_i => '0'
    );
    
    -- Output registers (WB slave -> user design)
    
    type t_spll_out_registers is record
      eccr_ext_en_o                            : std_logic;
      al_cr_valid_o                            : std_logic_vector(8 downto 0);
      al_cr_valid_load_o                       : std_logic;
      f_dmtd_valid_o                           : std_logic;
      f_dmtd_valid_load_o                      : std_logic;
      f_ref_valid_o                            : std_logic;
      f_ref_valid_load_o                       : std_logic;
      f_ext_valid_o                            : std_logic;
      f_ext_valid_load_o                       : std_logic;
      occr_out_lock_o                          : std_logic_vector(7 downto 0);
      rcer_o                                   : std_logic_vector(31 downto 0);
      rcer_load_o                              : std_logic;
      ocer_o                                   : std_logic_vector(7 downto 0);
      ocer_load_o                              : std_logic;
      dac_hpll_o                               : std_logic_vector(15 downto 0);
      dac_hpll_wr_o                            : std_logic;
      dac_main_value_o                         : std_logic_vector(15 downto 0);
      dac_main_value_wr_o                      : std_logic;
      dac_main_dac_sel_o                       : std_logic_vector(3 downto 0);
      dac_main_dac_sel_wr_o                    : std_logic;
      deglitch_thr_o                           : std_logic_vector(15 downto 0);
      dfr_spll_value_o                         : std_logic_vector(30 downto 0);
      dfr_spll_value_wr_o                      : std_logic;
      dfr_spll_eos_o                           : std_logic;
      dfr_spll_eos_wr_o                        : std_logic;
      dfr_host_wr_full_o                       : std_logic;
      dfr_host_wr_empty_o                      : std_logic;
      dfr_host_wr_usedw_o                      : std_logic_vector(12 downto 0);
      trr_wr_full_o                            : std_logic;
      trr_wr_empty_o                           : std_logic;
      end record;
    
    constant c_spll_out_registers_init_value: t_spll_out_registers := (
      eccr_ext_en_o => '0',
      al_cr_valid_o => (others => '0'),
      al_cr_valid_load_o => '0',
      f_dmtd_valid_o => '0',
      f_dmtd_valid_load_o => '0',
      f_ref_valid_o => '0',
      f_ref_valid_load_o => '0',
      f_ext_valid_o => '0',
      f_ext_valid_load_o => '0',
      occr_out_lock_o => (others => '0'),
      rcer_o => (others => '0'),
      rcer_load_o => '0',
      ocer_o => (others => '0'),
      ocer_load_o => '0',
      dac_hpll_o => (others => '0'),
      dac_hpll_wr_o => '0',
      dac_main_value_o => (others => '0'),
      dac_main_value_wr_o => '0',
      dac_main_dac_sel_o => (others => '0'),
      dac_main_dac_sel_wr_o => '0',
      deglitch_thr_o => (others => '0'),
      dfr_spll_value_o => (others => '0'),
      dfr_spll_value_wr_o => '0',
      dfr_spll_eos_o => '0',
      dfr_spll_eos_wr_o => '0',
      dfr_host_wr_full_o => '0',
      dfr_host_wr_empty_o => '0',
      dfr_host_wr_usedw_o => (others => '0'),
      trr_wr_full_o => '0',
      trr_wr_empty_o => '0'
      );
    function "or" (left, right: t_spll_in_registers) return t_spll_in_registers;
    function f_x_to_zero (x:std_logic) return std_logic;
    function f_x_to_zero (x:std_logic_vector) return std_logic_vector;
end package;

package body spll_wbgen2_pkg is
function f_x_to_zero (x:std_logic) return std_logic is
begin
if x = '1' then
return '1';
else
return '0';
end if;
end function;
function f_x_to_zero (x:std_logic_vector) return std_logic_vector is
variable tmp: std_logic_vector(x'length-1 downto 0);
begin
for i in 0 to x'length-1 loop
if(x(i) = 'X' or x(i) = 'U') then
tmp(i):= '0';
else
tmp(i):=x(i);
end if; 
end loop; 
return tmp;
end function;
function "or" (left, right: t_spll_in_registers) return t_spll_in_registers is
variable tmp: t_spll_in_registers;
begin
tmp.csr_n_ref_i := f_x_to_zero(left.csr_n_ref_i) or f_x_to_zero(right.csr_n_ref_i);
tmp.csr_n_out_i := f_x_to_zero(left.csr_n_out_i) or f_x_to_zero(right.csr_n_out_i);
tmp.csr_dbg_supported_i := f_x_to_zero(left.csr_dbg_supported_i) or f_x_to_zero(right.csr_dbg_supported_i);
tmp.eccr_ext_supported_i := f_x_to_zero(left.eccr_ext_supported_i) or f_x_to_zero(right.eccr_ext_supported_i);
tmp.eccr_ext_ref_present_i := f_x_to_zero(left.eccr_ext_ref_present_i) or f_x_to_zero(right.eccr_ext_ref_present_i);
tmp.al_cr_valid_i := f_x_to_zero(left.al_cr_valid_i) or f_x_to_zero(right.al_cr_valid_i);
tmp.al_cr_required_i := f_x_to_zero(left.al_cr_required_i) or f_x_to_zero(right.al_cr_required_i);
tmp.al_cref_i := f_x_to_zero(left.al_cref_i) or f_x_to_zero(right.al_cref_i);
tmp.al_cin_i := f_x_to_zero(left.al_cin_i) or f_x_to_zero(right.al_cin_i);
tmp.f_dmtd_freq_i := f_x_to_zero(left.f_dmtd_freq_i) or f_x_to_zero(right.f_dmtd_freq_i);
tmp.f_dmtd_valid_i := f_x_to_zero(left.f_dmtd_valid_i) or f_x_to_zero(right.f_dmtd_valid_i);
tmp.f_ref_freq_i := f_x_to_zero(left.f_ref_freq_i) or f_x_to_zero(right.f_ref_freq_i);
tmp.f_ref_valid_i := f_x_to_zero(left.f_ref_valid_i) or f_x_to_zero(right.f_ref_valid_i);
tmp.f_ext_freq_i := f_x_to_zero(left.f_ext_freq_i) or f_x_to_zero(right.f_ext_freq_i);
tmp.f_ext_valid_i := f_x_to_zero(left.f_ext_valid_i) or f_x_to_zero(right.f_ext_valid_i);
tmp.occr_out_en_i := f_x_to_zero(left.occr_out_en_i) or f_x_to_zero(right.occr_out_en_i);
tmp.rcer_i := f_x_to_zero(left.rcer_i) or f_x_to_zero(right.rcer_i);
tmp.ocer_i := f_x_to_zero(left.ocer_i) or f_x_to_zero(right.ocer_i);
tmp.dfr_host_wr_req_i := f_x_to_zero(left.dfr_host_wr_req_i) or f_x_to_zero(right.dfr_host_wr_req_i);
tmp.dfr_host_value_i := f_x_to_zero(left.dfr_host_value_i) or f_x_to_zero(right.dfr_host_value_i);
tmp.dfr_host_seq_id_i := f_x_to_zero(left.dfr_host_seq_id_i) or f_x_to_zero(right.dfr_host_seq_id_i);
tmp.trr_wr_req_i := f_x_to_zero(left.trr_wr_req_i) or f_x_to_zero(right.trr_wr_req_i);
tmp.trr_value_i := f_x_to_zero(left.trr_value_i) or f_x_to_zero(right.trr_value_i);
tmp.trr_chan_id_i := f_x_to_zero(left.trr_chan_id_i) or f_x_to_zero(right.trr_chan_id_i);
tmp.trr_disc_i := f_x_to_zero(left.trr_disc_i) or f_x_to_zero(right.trr_disc_i);
return tmp;
end function;
end package body;
