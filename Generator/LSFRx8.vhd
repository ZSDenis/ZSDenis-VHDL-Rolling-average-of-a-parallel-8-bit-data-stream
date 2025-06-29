
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity LFSRx8 is
Port (
    clk:in std_logic;
    rst:in std_logic;
    q:out std_logic_vector(7 downto 0);
     en:in std_logic

);
end LFSRx8;

architecture Behavioral of LFSRx8 is
  
signal temp:std_logic_vector(7 downto 0):="00000001";
begin

 process(clk,rst)
    begin
    if(rst='1')then 
        temp<="00000001";
          q<=(others=>'0');
    elsif(clk='1' and clk'event)then
      q<=temp;
    if(en='1')then
    temp(0)<=temp(6) xor temp(5) xor temp(4) xor temp(0);
    temp(7 downto 1)<=temp(6 downto 0); 
    end if;
end if;
end process;

end Behavioral;
