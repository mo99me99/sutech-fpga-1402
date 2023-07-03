----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Mohammad Mehdi Hosseini L
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

architecture WATERING_FSM_ARCH of WATERING is
    --decleration of a subtype (STATE_TYPE) to define different states:     
    subtype STATE_TYPE is std_logic_vector(1 downto 0 );
    signal NEXT_STATE : STATE_TYPE;
    constant ST2_START : STATE_TYPE :="11";
    constant ST0_STOP : STATE_TYPE :="00";
    constant ST1_WATERING : STATE_TYPE :="01";
    
begin
    REG: process(CLK,RESET) begin
        if RESET = '1' then STATE<=ST2_START;
        elsif (CLK'event and CLK = '1') then STATE<=NEXT_STATE;
        end if;
    end process REG;
    
    CMB:process(M_IN , L_IN , T_IN , STATE) begin
        case STATE is 
            -- in this case we just move to stop state because in FSM st2 goes to st0 with lambda
            when ST2_START =>
                NEXT_STATE <= ST0_STOP;
                
            when ST0_STOP => 
                --the 2 situations that we will stay in st0 :
                if(    ((T_IN='0' and L_IN ='0') and M_IN>"011")
                    or ((T_IN='1' or L_IN='1') and M_IN>"001")) then
                        NEXT_STATE <= ST0_STOP;
                            
                --the 2 situations that we will change our state to st1 :
                elsif (    ((T_IN='1' or L_IN='1')and M_IN <="001")
                    or ((T_IN='0' and L_IN ='0') and M_IN<= "011")) then 
                        NEXT_STATE <= ST1_WATERING;
                    end if ;
                    
            when ST1_WATERING =>
                --the 2 situations that we will stay in st1
                if(    ((T_IN='0' and L_IN='0')and M_IN<"111")
                    or((T_IN='1' or L_IN='1') and M_IN<"011")) then
                        NEXT_STATE <= ST1_WATERING;
                        
                --the 2 situations that we will change our state to st0 :
                elsif (    ((T_IN='1' or L_IN='1')and M_IN>="011")
                    or(M_IN>="111")) then
                        NEXT_STATE <= ST0_STOP;
                end if;
        end process CMB;
        
end WATERING_ARCH;
