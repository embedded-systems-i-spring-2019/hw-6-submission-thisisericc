library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity problem4 is
    Port (clk, X1, X2, INIT: in std_logic;
          Z1, Z2: out std_logic);
end problem4;

architecture myp4 of problem4 is

type state_type is (STA,STB,STC); 
signal PS,NS : state_type;

begin

sync_process: process (clk, NS, INIT) begin
                  if INIT = '1' then PS <= STA;
                  elsif rising_edge(clk) then PS <= NS;
                  end if;
              end process sync_process;
              
comb_process: process (PS, X1, X2) begin
                            
                  Z1 <= '0'; Z2 <= '0';
                  
                  case PS is
                      when STA =>
                          Z1 <= '0';
                          if X1 = '1' then NS <= STB; Z2 <= '1';
                          else NS <= STC; Z2 <= '0';
                          end if;
                      when STB =>
                          Z1 <= '1';
                          if X2 = '1' then NS <= STA; Z2 <= '0';
                          else NS <= STC; Z2 <= '1';
                          end if;
                      when STC =>
                          Z1 <= '1';
                          if X1 = '1' then NS <= STB; Z2 <= '1';
                          else NS <= STA; Z2 <= '0';
                          end if;
                      when others =>
                          NS <= STA; Z1 <= '0'; Z2 <= '0';
                    end case;
                end process comb_process;
end myp4;
