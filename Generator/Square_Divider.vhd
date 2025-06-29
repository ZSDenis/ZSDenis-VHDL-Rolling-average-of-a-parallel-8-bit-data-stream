
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Divizor_square is
 Port (
    ckf:in std_logic;
    rst:in std_logic;
    square_clk:out std_logic
 );
end Divizor_square;

architecture Behavioral of Divizor_square is
    signal temp:std_logic := '0';
begin
    process(ckf,rst)
        variable counter:integer range 1 to 2 :=1;
    begin
        if(rst='1')then
            temp<='0';
            counter:=1;
        elsif(ckf'event and ckf='1')then
            if(counter=2)then
                temp<=not temp;
                counter:=1;
            else
                counter:=counter+1;
            end if;
        end if;
    end process;
    square_clk<=temp;
end Behavioral;
