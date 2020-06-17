-- -------------------------------------------------------------
-- 
-- File Name: C:\Users\USER\Desktop\Farneback_blockRAM\blockram_v2\codegen\blockram\hdlsrc\blockram_fixpt.vhd
-- Created: 2020-06-13 13:03:51
-- 
-- Generated by MATLAB 9.7, MATLAB Coder 4.3 and HDL Coder 3.15
-- 
-- 
-- 
-- -------------------------------------------------------------
-- Rate and Clocking Details
-- -------------------------------------------------------------
-- Design base rate: 1
-- 
-- 
-- Clock Enable  Sample Time
-- -------------------------------------------------------------
-- ce_out        1
-- -------------------------------------------------------------
-- 
-- 
-- Output Signal                 Clock Enable  Sample Time
-- -------------------------------------------------------------
-- outdata                       ce_out        1
-- -------------------------------------------------------------
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: blockram_fixpt
-- Source Path: blockram_fixpt
-- Hierarchy Level: 0
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.blockram_fixpt_pkg.ALL;

ENTITY blockram_fixpt IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        clk_enable                        :   IN    std_logic;
        indata                            :   IN    std_logic_vector(22 DOWNTO 0);  -- ufix23
        ce_out                            :   OUT   std_logic;
        outdata                           :   OUT   std_logic_vector(22 DOWNTO 0)  -- ufix23
        );
END blockram_fixpt;


ARCHITECTURE rtl OF blockram_fixpt IS

  -- Signals
  SIGNAL enb                              : std_logic;
  SIGNAL indata_unsigned                  : unsigned(22 DOWNTO 0);  -- ufix23
  SIGNAL ctr                              : unsigned(7 DOWNTO 0);  -- ufix8
  SIGNAL ctr_1                            : unsigned(7 DOWNTO 0);  -- ufix8
  SIGNAL tmp                              : unsigned(7 DOWNTO 0);  -- ufix8
  SIGNAL tmp_1                            : std_logic;
  SIGNAL tmp_2                            : unsigned(7 DOWNTO 0);  -- ufix8
  SIGNAL tmp_3                            : vector_of_unsigned23(0 TO 199);  -- ufix23 [200]
  SIGNAL row                              : vector_of_unsigned23(0 TO 199);  -- ufix23 [200]
  SIGNAL outdata_tmp                      : unsigned(22 DOWNTO 0);  -- ufix23
  SIGNAL p6outdata_sub_cast               : signed(31 DOWNTO 0);  -- int32

BEGIN
  enb <= clk_enable;

  indata_unsigned <= unsigned(indata);

  -- HDL code generation from MATLAB function: blockram_fixpt_trueregionp2
  ctr <= to_unsigned(16#01#, 8);

  -- HDL code generation from MATLAB function: blockram_fixpt
  -- 
  -- HDL code generation from MATLAB function: blockram_fixpt_falseregionp2
  tmp <= ctr_1 + to_unsigned(16#01#, 8);

  ---------------------- ctr counter
  
  tmp_1 <= '1' WHEN ctr_1 = to_unsigned(16#C8#, 8) ELSE
      '0';

  
  tmp_2 <= tmp WHEN tmp_1 = '0' ELSE
      ctr;

  ctr_reg_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      ctr_1 <= to_unsigned(16#01#, 8);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        ctr_1 <= tmp_2;
      END IF;
    END IF;
  END PROCESS ctr_reg_process;


  row_reg_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      row <= (OTHERS => to_unsigned(16#000000#, 23));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        row <= tmp_3;
      END IF;
    END IF;
  END PROCESS row_reg_process;


  -- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  -- 
  --                                                                          %
  -- 
  --           Generated by MATLAB 9.7 and Fixed-Point Designer 6.4           %
  -- 
  --                                                                          %
  -- 
  -- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  -- 
  ---------------------- Initial blockram 
  -- 
  ---------------------- write BRAM
  p8tmp_output : PROCESS (ctr_1, indata_unsigned, row)
    VARIABLE sub_cast : signed(31 DOWNTO 0);
  BEGIN
    tmp_3 <= row;
    sub_cast := signed(resize(ctr_1, 32));
    tmp_3(to_integer(sub_cast - 1)) <= indata_unsigned;
  END PROCESS p8tmp_output;


  ---------------------- read
  p6outdata_sub_cast <= signed(resize(ctr_1, 32));
  outdata_tmp <= tmp_3(to_integer(p6outdata_sub_cast - 1));

  outdata <= std_logic_vector(outdata_tmp);

  ce_out <= clk_enable;

END rtl;

