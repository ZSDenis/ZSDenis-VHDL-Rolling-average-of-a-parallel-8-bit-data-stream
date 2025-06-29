library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;
use IEEE.NUMERIC_STD.ALL;

use work.Types.all;

entity Avg16Samples is
  Port (
    rst, full : in std_logic;
    y : in matrice;
    avg_out : out std_logic_vector(7 downto 0)
  );
end Avg16Samples;

architecture Behavioral of Avg16Samples is
begin

  process(rst,y,full)
    variable local_sum : std_logic_vector(11 downto 0) := (others => '0'); 
  begin
    if (rst = '1') then
      avg_out <= (others => '0');
      local_sum := (others => '0'); 
    elsif (full = '1') then
      local_sum := (others => '0'); 
      for i in 0 to 15 loop
        local_sum := local_sum + ("0000" & y(i)); -- extindem la 12 
      end loop;
      avg_out <= local_sum(11 downto 4); -- div la 16
    end if;
  end process;



end Behavioral;
