library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity problem2 is
  Port (clk, X1, X2: in std_logic;
        Z: out std_logic;
        Y: out std_logic_vector(1 downto 0));
end problem2;

architecture myp2 of problem2 is

type state_type is (STA,STB,STC); 
attribute ENUM_ENCODING: STRING; 
attribute ENUM_ENCODING of state_type: type is "10 11 01"; 
signal PS,NS : state_type;

begin

sync_process: process (clk, NS) begin
                  if rising_edge(clk) then
                    PS <= NS;
                  end if;
              end process sync_process;

comb_process: process (PS, X1, X2) begin
              
                Z <= '0';
                
                case PS is
                    when STA =>
                        if X1 = '1' then NS <= STC; Z <= '0';
                        else NS <= STA; Z <= '0';
                        end if;
                    when STB =>
                        if X2 = '1' then NS <= STB; Z <= '0';
                        else NS <= STA; Z <= '1';
                        end if;
                    when STC =>
                        if X2 = '1' then NS <= STB; Z <= '0';
                        else NS <= STA; Z <= '1';
                        end if;
                    when others =>
                        NS <= STA; Z <= '0';
                  end case;
              end process comb_process;

with PS select
    Y <= "10" when STA,
         "11" when STB,
         "01" when STC,
         "10" when others;
end myp2;
