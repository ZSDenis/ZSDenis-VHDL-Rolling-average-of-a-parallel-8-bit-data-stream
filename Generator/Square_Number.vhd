
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SquareWave is
Port (
    clk,rst:in std_logic;
    clk_sqr:out std_logic;
    q:out std_logic_vector(7 downto 0)
);
end SquareWave;

architecture Behavioral of SquareWave is
    component Divizor_square
    Port (
        ckf :in std_logic;
        rst :in std_logic;
        square_clk:out std_logic
    );
    end component;
signal clk_temp:std_logic;
    signal temp : std_logic_vector(7 downto 0):="00000000";
begin
divider:Divizor_square port map(clk,rst,clk_temp);
    process(clk_temp,rst)
begin
    if rst='1' then
        temp<=(others =>'0');
    elsif (clk_temp'event and clk_temp='1') then
        temp <= not temp;
    end if;
end process;
clk_sqr<=clk_temp;
q<=temp;
end Behavioral;
