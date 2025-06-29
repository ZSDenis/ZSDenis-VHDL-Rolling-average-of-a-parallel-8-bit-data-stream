library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;
use IEEE.NUMERIC_STD.ALL;

use work.Types.all;

entity Avg4Samples is
  Port (
    rst,full:in  std_logic;
    y : in  matrice;
    avg_out : out std_logic_vector(7 downto 0) 
  );
end Avg4Samples;

architecture Behavioral of Avg4Samples is
begin
  process(rst,y,full)
    variable local_sum : std_logic_vector(9 downto 0) := (others => '0'); 
  begin
    if (rst = '1') then
      avg_out <= (others => '0');
      local_sum := (others => '0'); 
    elsif(full = '1') then
      local_sum := (others => '0'); 
      for i in 12 to 15 loop
        local_sum := local_sum + ("00" & y(i)); -- extindem 8  la 10 
      end loop;
      avg_out <= local_sum(9 downto 2); -- div la 4
    end if;
  end process;

end Behavioral;

