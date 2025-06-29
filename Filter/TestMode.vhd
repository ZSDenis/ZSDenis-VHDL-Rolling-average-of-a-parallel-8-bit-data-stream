library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TestMode is
  Port (
   clk, rst : in std_logic;
    sw :in std_logic_vector(2 downto 0);
    x   : in std_logic_vector(7 downto 0);
    y   : out std_logic_vector(7 downto 0)
  );
end TestMode;

architecture Behavioral of TestMode is
  signal temp : std_logic_vector(7 downto 0) := (others => '0');
  signal en:std_logic:='1';
begin
en<='0' when sw="000" else '1';
  process(rst,en,x)
  begin
      if (rst='1') then
        temp<=(others => '0');
    elsif(en='1')then 
        temp<=x;
      end if;
  end process;
  y <= temp;

end Behavioral;
