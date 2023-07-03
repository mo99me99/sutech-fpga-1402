----------------------------------------------------------------------------------
-- Company: Shiraz University of Technology
-- Engineer: Mohammad Mehdi Hosseini L
-- 
-- Create Date: 07/03/2023 05:21:51 AM
-- Module Name: WATERING - WATERING_ARCH
-- Project Name: WATERING SYSTEM
-- Target Devices: FPGAs
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
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
    signal STATE_OUT , NEXT_STATE : STATE_TYPE;
    constant ST2_START : STATE_TYPE :="11";
    constant ST0_STOP : STATE_TYPE :="00";
    constant ST1_WATERING : STATE_TYPE :="01";
    
begin
    --this process with a sensivity list of CLK and RESET will update the status of system and assigns next state that generated by CMB to current state
    --  notice that if RESET signal be actived system goes to st2 and will be reset.
    REG_PROCESS: process(CLK,RESET) begin
        if RESET = '1' then STATE<=ST2_START;
        elsif (CLK'event and CLK = '1') then STATE<=NEXT_STATE; STATE_OUT<=NEXT_STATE;
        end if;
    end process REG_PROCESS;
    
    
    --In this combinational block we check all input signals to recognize the next state that machine has to take.
    CMB_PROCESS:process(M_IN , L_IN , T_IN , STATE_OUT) begin
        --default (this way of assignment of default cases , avoids using latch and makes system more clear in synthesis)
        NEXT_STATE <= ST2_START;
        case STATE_OUT is 
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
            end case;
        end process CMB_PROCESS;
        
        
    -- in this process a 7-segment output will be generated that shows 'H' while the system is in st1 and watering happens
    --     and shows '-' while system is in state st0 and avoids watering because of situation.
    SEGMENT_PROCESS :process(STATE_OUT) begin
        if(STATE_OUT = ST0_STOP) then 
            SEG <= "01110110";
        elsif(STATE_OUT = ST1_WATERING) then
            SEG <= "0100000";
        end if;
    end process SEGMENT_PROCESS;
    
    -- assignment binary outputs that going to show with LEDs
    M_OUT <= M_IN;
    L_OUT <= L_IN;
    T_OUT <= T_IN;
        
end WATERING_FSM_ARCH;

