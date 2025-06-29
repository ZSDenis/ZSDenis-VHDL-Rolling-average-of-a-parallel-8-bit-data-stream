library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity Student1 is
Port (
    clk,rst:in std_logic;
    q:out std_logic_vector(7 downto 0);
    en:in std_logic
);
end Student1;
architecture Behavioral of Student1 is
    type Student_Array is array(0 to 5) of std_logic_vector(7 downto 0);
    constant student: Student_Array :=("00000001", "00000010", "00000011","00000100", "00000101", "00000110");
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