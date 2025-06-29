library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Test is
  Port (
  q : out std_logic_vector(7 downto 0)
   );
end Test;

architecture Behavioral of Test is

begin
q<=(others=>'0');

end Behavioral;
