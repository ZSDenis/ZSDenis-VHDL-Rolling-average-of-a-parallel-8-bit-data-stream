library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;
use IEEE.NUMERIC_STD.ALL;

use work.Types.all;

entity Avg8Samples is
  Port (
    rst,full:in  std_logic;
    y : in  matrice;
    avg_out : out std_logic_vector(7 downto 0)
  );
end Avg8Samples;

architecture Behavioral of Avg8Samples is
begin

  process(rst,y,full)
    variable local_sum : std_logic_vector(10 downto 0) := (others => '0'); 
  begin
    if (rst = '1') then
      avg_out <= (others => '0');
      local_sum := (others => '0'); 
    elsif(full = '1') then
      local_sum := (others => '0'); 
      for i in 8 to 15 loop
        local_sum := local_sum + ("000" & y(i)); -- extindere la 11 biți
      end loop;
      avg_out <= local_sum(10 downto 3); -- împărțire la 8 (>>3)
    end if;
  end process;
end Behavioral;
