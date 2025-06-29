library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.Types.all;

entity Buff is
  Port (
    clk, rst, en: in std_logic;
    d_in: in std_logic_vector(7 downto 0);
    y: out matrice ;
    full: out std_logic_vector(3 downto 0)
  );
end Buff;

architecture Behavioral of Buff is
begin
  process(clk,d_in,rst,en)
   variable storage: matrice := (others => (others => '0'));
     variable counter: integer range 0 to 16 := 0;
   variable  full_temp:std_logic_vector(3 downto 0);
  begin
   
      if rst = '1' then
        full_temp:= "0000";
        storage := (others => (others => '0'));
        counter := 0;
        else 
    if clk'event and clk = '0' then
      if en = '1' then
          for i in 0 to 14 loop
            storage(i) := storage(i+1);
          end loop;
       storage(15) := d_in;
        if counter < 17 then
          counter := counter+1;
        end if;
      end if;
    end if;
    end if;
    
    if (counter>1)then 
       full_temp(0):='1';
       if(counter >3)then 
         full_temp(1):='1';
        if(counter>7) then 
          full_temp(2) := '1';
        if(counter>15)then 
           full_temp(3):='1';
     end if;
     end if;
     end if;
    end if;

      y <=storage;
      full<=full_temp;
  end process;
end Behavioral;
