
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux8 is
 Port (
  sel:in std_logic_vector (2 downto 0);
   d0,d1,d2,d3,d4,d5,d6,d7:in std_logic_vector(7 downto 0);
    y:out std_logic_vector(7 downto 0)
  );
end Mux8;

architecture Behavioral of Mux8 is
begin
    with sel select 
        y <= d0 when "000",
             d1 when "001",
             d2 when "010",
             d3 when "011",
             d4 when "100",
             d5 when "101",
             d6 when "110",
             d7 when "111",
             (others => '0') when others;
end Behavioral;