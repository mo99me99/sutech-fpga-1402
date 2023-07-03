----------------------------------------------------------------------------------
-- Company: SUTECH
-- Engineer: M M Hosseini L
-- 
-- Create Date: 07/03/2023 10:24:55 AM
-- Module Name: WATERING_SYS_TESTBENCH - Behavioral
-- Project Name: WATERING SYSTEM
-- Target Devices: FPGAs 
-- Description: test bench
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity WATERING_SYS_TESTBENCH is
end WATERING_SYS_TESTBENCH;

architecture TB_WATERING_SYS_ARCH of WATERING_SYS_TESTBENCH is
    component WATERING is
        Port (
            --inputs : 
            RESET : in std_logic;
            CLK : in std_logic;
            M_IN : in std_logic_vector(2 downto 0);
            L_IN : in std_logic;
            T_IN : in std_logic;
            
            --outputs : 
            STATE : out std_logic_vector(1 downto 0);
            SEG : out std_logic_vector(6 downto 0 );
            M_OUT : out std_logic_vector(2 downto 0);
            L_OUT : out std_logic;
            T_OUT : out std_logic    
        );
    end component WATERING;
    
    signal RESET,CLK,L_IN,T_IN,L_OUT,T_OUT : std_logic;
    signal M_IN,M_OUT :  std_logic_vector(2 downto 0); 
    signal STATE : std_logic_vector(1 downto 0);
    signal SEG :  std_logic_vector(6 downto 0) ;
begin
end architecture TB_WATERING_SYS_ARCH;
