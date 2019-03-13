library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity problem6 is
    Port (clk, X: in std_logic;
          Z1, Z2: out std_logic;
          Y: out std_logic_vector(1 downto 0));
end problem6;

architecture myp6 of problem6 is

type state_type is (ST0,ST1,ST2,ST3); 
attribute ENUM_ENCODING: STRING; 
attribute ENUM_ENCODING of state_type: type is "00 01 10 11"; 
signal PS,NS : state_type;

begin

sync_process: process (clk, NS) begin
                  if rising_edge(clk) then
                    PS <= NS;
                  end if;
              end process sync_process;
              
comb_process: process (PS,X) begin
                                          
                                Z1 <= '0'; Z2 <= '0';
                                
                                case PS is
                                    when ST0 =>
                                        Z1 <= '1';
                                        if X = '1' then NS <= ST0; Z2 <= '0';
                                        else NS <= ST2; Z2 <= '0';
                                        end if;
                                    when ST1 =>
                                        Z1 <= '0';
                                        if X = '1' then NS <= ST1; Z2 <= '0';
                                        else NS <= ST3; Z2 <= '0';
                                        end if;
                                    when ST2 =>
                                        Z1 <= '1';
                                        if X = '1' then NS <= ST0; Z2 <= '0';
                                        else NS <= ST1; Z2 <= '0';
                                        end if;
                                    when ST3 =>
                                        Z1 <= '0';
                                        if X = '1' then NS <= ST1; Z2 <= '0';
                                        else NS <= ST0; Z2 <= '1';
                                        end if;
                                    when others =>  
                                        NS <= ST0; Z1 <= '0'; Z2 <= '0';
                                  end case;
                              end process comb_process;
                              
with PS select
      Y <= "00" when ST0,
           "01" when ST1,
           "10" when ST2,
           "11" when ST3,
           "00" when others;

end myp6;
