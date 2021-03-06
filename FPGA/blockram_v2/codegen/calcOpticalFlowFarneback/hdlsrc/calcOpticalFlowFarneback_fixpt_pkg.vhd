-- -------------------------------------------------------------
-- 
-- File Name: C:\Users\USER\Desktop\Farneback_blockRAM\blockram_v2\codegen\calcOpticalFlowFarneback\hdlsrc\calcOpticalFlowFarneback_fixpt_pkg.vhd
-- Created: 2020-06-04 16:22:57
-- 
-- Generated by MATLAB 9.7, MATLAB Coder 4.3 and HDL Coder 3.15
-- 
-- 
-- -------------------------------------------------------------


LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

PACKAGE calcOpticalFlowFarneback_fixpt_pkg IS
  TYPE vector_of_unsigned8 IS ARRAY (NATURAL RANGE <>) OF unsigned(7 DOWNTO 0);
  TYPE vector_of_signed32 IS ARRAY (NATURAL RANGE <>) OF signed(31 DOWNTO 0);
  TYPE vector_of_unsigned10 IS ARRAY (NATURAL RANGE <>) OF unsigned(9 DOWNTO 0);
END calcOpticalFlowFarneback_fixpt_pkg;

