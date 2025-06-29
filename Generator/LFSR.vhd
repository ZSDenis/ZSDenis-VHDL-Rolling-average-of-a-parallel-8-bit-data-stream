
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity LFSRx4 is
Port (
    clk:in std_logic;
    rst:in std_logic;
    q:out std_logic_vector(7 downto 0);
    en:in std_logic
);
end LFSRx4;

architecture Behavioral of LFSRx4 is
signal temp:std_logic_vector(3 downto 0);
begin
 process(clk,rst)
    begin
    if(rst='1')then 
        temp<="0001";
          q<=(others=>'0');
    elsif(clk='1' and clk'event)then
      q<="0000"&temp(3 downto 0);
    if(en='1')then
    temp(0)<=temp(3) xor temp(0);
    temp(3 downto 1)<=temp(2 downto 0); 
    end if;
end if;
end process;

end Behavioral;
