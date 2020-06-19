-- -------------------------------------------------------------
-- 
-- File Name: C:\Users\USER\Desktop\Farneback_blockRAM\blockram_v2\codegen\PolyExp_pipeline4\hdlsrc\PolyExp_pipeline4_fixpt_pkg.vhd
-- Created: 2020-06-19 13:28:53
-- 
-- Generated by MATLAB 9.7, MATLAB Coder 4.3 and HDL Coder 3.15
-- 
-- 
-- -------------------------------------------------------------


LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

PACKAGE PolyExp_pipeline4_fixpt_pkg IS
  TYPE vector_of_unsigned14 IS ARRAY (NATURAL RANGE <>) OF unsigned(13 DOWNTO 0);
  TYPE vector_of_signed14 IS ARRAY (NATURAL RANGE <>) OF signed(13 DOWNTO 0);
  TYPE vector_of_signed32 IS ARRAY (NATURAL RANGE <>) OF signed(31 DOWNTO 0);
  TYPE vector_of_signed17 IS ARRAY (NATURAL RANGE <>) OF signed(16 DOWNTO 0);
  TYPE vector_of_unsigned5 IS ARRAY (NATURAL RANGE <>) OF unsigned(4 DOWNTO 0);
  TYPE vector_of_signed31 IS ARRAY (NATURAL RANGE <>) OF signed(30 DOWNTO 0);
  TYPE vector_of_signed15 IS ARRAY (NATURAL RANGE <>) OF signed(14 DOWNTO 0);
  TYPE vector_of_signed30 IS ARRAY (NATURAL RANGE <>) OF signed(29 DOWNTO 0);
  TYPE vector_of_signed29 IS ARRAY (NATURAL RANGE <>) OF signed(28 DOWNTO 0);
  TYPE vector_of_unsigned30 IS ARRAY (NATURAL RANGE <>) OF unsigned(29 DOWNTO 0);
  TYPE vector_of_unsigned15 IS ARRAY (NATURAL RANGE <>) OF unsigned(14 DOWNTO 0);
  TYPE vector_of_unsigned28 IS ARRAY (NATURAL RANGE <>) OF unsigned(27 DOWNTO 0);
  TYPE vector_of_unsigned31 IS ARRAY (NATURAL RANGE <>) OF unsigned(30 DOWNTO 0);
  TYPE vector_of_unsigned29 IS ARRAY (NATURAL RANGE <>) OF unsigned(28 DOWNTO 0);
  TYPE vector_of_unsigned8 IS ARRAY (NATURAL RANGE <>) OF unsigned(7 DOWNTO 0);
END PolyExp_pipeline4_fixpt_pkg;

