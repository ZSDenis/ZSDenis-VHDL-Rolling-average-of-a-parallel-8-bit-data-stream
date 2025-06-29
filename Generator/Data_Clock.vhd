library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Data_Clock is
 Port (
    ckf:in std_logic;
    rst:in std_logic;
    clk:out std_logic
      );
end Data_Clock;

architecture Behavioral of Data_Clock is
    signal temp:std_logic :='0';
begin
    process(ckf,rst)
        variable counter:integer range 1 to 100_000_000 := 1;
    begin
        if(rst='1')then
            temp <='0';
            counter:=1;
        elsif(ckf'event and ckf = '1')then
            if counter= 100_000_000  then
                temp<=not temp;
                counter:=1;
            else
                counter:=counter+1;
            end if;
        end if;
    end process;
    
    clk <= temp;
end Behavioral;
