----------------------------------------------------------------------------------
-- Company: Shiraz University of Technology
-- Engineer: Mohammad Mehdi Hosseini L
-- Create Date: 07/03/2023 10:12:28 AM
-- Module Name: watering_system_package - Behavioral
-- Project Name: WATERING SYSTEM
-- Target Devices: FPGAs
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
package WATERIGN_SYSTEM is 
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
end package ;