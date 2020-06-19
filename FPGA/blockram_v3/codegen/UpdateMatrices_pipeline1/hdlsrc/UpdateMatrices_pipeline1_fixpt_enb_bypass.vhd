-- -------------------------------------------------------------
-- 
-- File Name: C:\Users\USER\Desktop\Farneback_blockRAM\blockram_v2\codegen\UpdateMatrices_pipeline1\hdlsrc\UpdateMatrices_pipeline1_fixpt_enb_bypass.vhd
-- Created: 2020-06-19 13:30:52
-- 
-- Generated by MATLAB 9.7, MATLAB Coder 4.3 and HDL Coder 3.15
-- 
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: UpdateMatrices_pipeline1_fixpt_enb_bypass
-- Source Path: 
-- Hierarchy Level: 1
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY UpdateMatrices_pipeline1_fixpt_enb_bypass IS
  PORT( clk_1                             :   IN    std_logic;
        reset_1                           :   IN    std_logic;
        clk_enable_1                      :   IN    std_logic;
        clk_enable_2                      :   OUT   std_logic
        );
END UpdateMatrices_pipeline1_fixpt_enb_bypass;


ARCHITECTURE rtl OF UpdateMatrices_pipeline1_fixpt_enb_bypass IS

  -- Signals
  SIGNAL clk_enable_3                     : std_logic;
  SIGNAL ctr0_out                         : std_logic;
  SIGNAL ctrstate_out                     : std_logic;
  SIGNAL bypass_out                       : std_logic;
  SIGNAL clk_enable_4                     : std_logic;

BEGIN
  c_process: PROCESS (clk_1, reset_1)
  BEGIN
    IF reset_1 = '1' THEN
      ctr0_out <= '0';
    ELSIF clk_1'event AND clk_1 = '1' THEN
      ctr0_out <= clk_enable_3 AND clk_enable_1;
    END IF;
  END PROCESS c_process;

  ctrstate_out <= NOT clk_enable_1 WHEN clk_enable_3 = '1' ELSE
                  ctr0_out;

  c_1_process: PROCESS (clk_1, reset_1)
  BEGIN
    IF reset_1 = '1' THEN
      clk_enable_3 <= '1';
    ELSIF clk_1'event AND clk_1 = '1' THEN
      clk_enable_3 <= ctrstate_out;
    END IF;
  END PROCESS c_1_process;

  c_2_process: PROCESS (clk_1, reset_1)
  BEGIN
    IF reset_1 = '1' THEN
      bypass_out <= '0';
    ELSIF clk_1'event AND clk_1 = '1' THEN
      IF clk_enable_3 = '1' THEN
        bypass_out <= clk_enable_1;
      END IF;
    END IF;
  END PROCESS c_2_process;

  clk_enable_4 <= clk_enable_1 WHEN clk_enable_3 = '1' ELSE
                  bypass_out;

  clk_enable_2 <= clk_enable_4;

END rtl;
