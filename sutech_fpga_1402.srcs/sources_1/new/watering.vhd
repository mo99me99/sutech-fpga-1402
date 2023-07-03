----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/03/2023 05:21:51 AM
-- Design Name: 
-- Module Name: WATERING - WATERING_ARCH
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;



entity WATERING is
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
end WATERING;

architecture WATERING_ARCH of WATERING is
begin
end WATERING_ARCH;
