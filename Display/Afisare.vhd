library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;

entity Display is
    Port ( 
        clk:in std_logic;  
        reset:in std_logic;
        nr,avg:in std_logic_vector (7 downto 0);
        anod:out std_logic_vector (3 downto 0); 
        catod:out std_logic_vector (7 downto 0) 
    );
end Display;

architecture Behavioral of Display is
    signal LED_BCD:STD_LOGIC_VECTOR (3 downto 0);
    signal counter:STD_LOGIC_VECTOR (19 downto 0);
    signal LED_activ:std_logic_vector(1 downto 0);
    signal nr_final :STD_LOGIC_VECTOR(15 downto 0); -- nr & avg
begin
process(LED_BCD)
    begin
        case LED_BCD is
            when "0000" => catod(6 downto 0)<= "1000000"; -- "0"
            when "0001" => catod(6 downto 0)<= "1111001"; -- "1"
            when "0010" => catod(6 downto 0)<= "0100100"; -- "2"
            when "0011" => catod(6 downto 0)<= "0110000"; -- "3"
            when "0100" => catod(6 downto 0)<= "0011001"; -- "4"
            when "0101" => catod(6 downto 0)<= "0010010"; -- "5"
            when "0110" => catod(6 downto 0)<= "0000010"; -- "6"
            when "0111" => catod(6 downto 0)<= "1111000"; -- "7"
            when "1000" => catod(6 downto 0)<= "0000000"; -- "8"
            when "1001" => catod(6 downto 0)<= "0011000"; -- "9"
            when "1010" => catod(6 downto 0)<= "0001000"; -- "A"
            when "1011" => catod(6 downto 0)<= "0000011"; -- "b"
            when "1100" => catod(6 downto 0)<= "1000110"; -- "C"
            when "1101" => catod(6 downto 0)<= "0100001"; -- "d"
            when "1110" => catod(6 downto 0)<= "0000110"; -- "E"
            when "1111" => catod(6 downto 0)<= "0001110"; -- "F"
            when others => catod(6 downto 0)<= "1111111";
        end case;
         catod(7) <= '1'; --punctul zecimal dezactivat 
    end process;
    
nr_final <= nr & avg; -- nr_generat+media

   process(clk,reset)
    begin 
        if(reset='1') then
            counter <= (others => '0');
        elsif(clk'event and clk='1') then
            counter<=counter+1;
        end if;
    end process;
    LED_activ <= counter(19 downto 18);
    process(LED_activ)
    begin
        case LED_activ is
            when "00" =>
                anod <= "0111"; 
                LED_BCD <= nr_final(15 downto 12);
            when "01" =>
                anod <= "1011"; 
                LED_BCD <= nr_final(11 downto 8);
            when "10" =>
                anod <= "1101"; 
                LED_BCD <= nr_final(7 downto 4);
            when "11" =>
                anod <= "1110"; 
                LED_BCD <= nr_final(3 downto 0);
            when others => null;
        end case;
    end process;
end Behavioral;
