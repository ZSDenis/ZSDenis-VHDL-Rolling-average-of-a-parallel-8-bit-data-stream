library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Student2 is
Port (
    clk,rst:in std_logic;
    q:out std_logic_vector(7 downto 0);
     en:in std_logic
);
end Student2;
architecture Behavioral of Student2 is
type Student_Array is array(0 to 5) of std_logic_vector(7 downto 0);
constant student:Student_Array := (  x"2C", x"1F", x"10", x"3E", x"2A", x"02");
begin
process(clk,rst)
   variable adr : integer := 0;
begin
 if (rst = '1') then
    adr := 0;
    q <=(others=>'0');

  elsif (clk'event and clk='1') then
    q <=student(adr);
    if (en='1') then
      adr :=(adr + 1) mod 6;        
    end if;
  end if;
end process;
end Behavioral;