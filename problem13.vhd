library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity problem13 is
    Port ( clk : in STD_LOGIC;
           X1 : in STD_LOGIC;
           X2 : in STD_LOGIC;
           Y : out STD_LOGIC_VECTOR (2 downto 0);
           CS : out STD_LOGIC;
           RD : out STD_LOGIC);
end problem13;

architecture myp13 of problem13 is

type state_type is (STA,STB,STC); 
attribute ENUM_ENCODING: STRING; 
attribute ENUM_ENCODING of state_type: type is "001 010 100"; 
signal PS,NS : state_type;

begin

sync_process: process (clk, NS) begin
                  if rising_edge(clk) then
                    PS <= NS;
                  end if;
              end process sync_process;
              
comb_process: process (PS, X1, X2) begin
                            
                              CS <= '0'; RD <= '0';
                              
                              case PS is
                                  when STA =>
                                      if X1 = '1' then NS <= STC; RD <= '0'; CS <= '1';
                                      else NS <= STB; CS <= '0'; RD <= '1';
                                      end if;
                                  when STB =>
                                      NS <= STC; CS <= '1'; RD <= '1';
                                  when STC =>
                                      if X2 = '1' then NS <= STC; CS <= '0'; RD <= '1';
                                      else NS <= STA; CS <= '0'; RD <= '0';
                                      end if;
                                  when others =>
                                      NS <= STA; CS <= '0'; RD <= '0';
                                end case;
                            end process comb_process;
              
with PS select
  Y <= "001" when STA,
       "010" when STB,
       "100" when STC,
       "001" when others;

end myp13;
