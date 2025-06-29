

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Data_Generator is
 Port ( 
 clk,rst:in std_logic;
 switches:in std_logic_vector (2 downto 0);
 data:out std_logic_vector (7 downto 0);
 data_clk:out std_logic
 );
end Data_Generator;


architecture Behavioral of Data_Generator is
component Test is
  Port (
  q : out std_logic_vector(7 downto 0)
   );
end component;

component SquareWave is
Port (
    clk,rst:in std_logic;
    clk_sqr:out std_logic;
    q:out std_logic_vector(7 downto 0)
);
end component;

component Student1 is
Port (
    clk,rst:in std_logic;
    q:out std_logic_vector(7 downto 0);
    en:in std_logic
);
end component;

component Student2 is
Port (
    clk,rst:in std_logic;
    q:out std_logic_vector(7 downto 0);
     en:in std_logic
);
end component;

component LFSRx4 is
Port (
    clk:in std_logic;
    rst:in std_logic;
    q:out std_logic_vector(7 downto 0);
         en:in std_logic
);
end component;

component LFSRx8 is
Port (
    clk:in std_logic;
    rst:in std_logic;
    q:out std_logic_vector(7 downto 0);
         en:in std_logic

);
end component;

component Data_Clock is
 Port (
    ckf:in std_logic;
    rst:in std_logic;
    clk:out std_logic
     );
end component;

component Mux8 is
 Port (
  sel:in std_logic_vector (2 downto 0);
   d0,d1,d2,d3,d4,d5,d6,d7:in std_logic_vector(7 downto 0);
    y:out std_logic_vector(7 downto 0)
  );
end component;

type matrice is array (0 to 7) of std_logic_vector (7 downto 0);
signal temp:matrice:=(others =>(others=>'0'));
signal clk_fltr:std_logic;
signal clk_sqr:std_logic;
signal en_comp:std_logic_vector(3 downto 0):= "0000"; --activez componenta doar cand e selectat de sw
begin
tst: Test port map (temp(0));
sqwv: SquareWave port map (clk_fltr,rst,clk_sqr,temp(1));
st1: Student1 port map (clk_fltr,rst,temp(2),en_comp(0));
st2: Student2 port map (clk_fltr,rst,temp(3),en_comp(1));
lfsr4: LFSRx4 port map (clk_fltr,rst,temp(6),en_comp(2));
lfsr8: LFSRx8 port map (clk_fltr,rst,temp(7),en_comp(3));
dclk: Data_Clock port map (clk,rst,clk_fltr);
mux: Mux8 port map (switches,temp(0),temp(1),temp(2),temp(3),temp(0),temp(0),temp(6),temp(7),data);

en_comp(0)<='1' when switches="010" else '0';--comp student 1
en_comp(1)<='1' when switches="011" else '0';--comp student 2
en_comp(2)<='1' when switches="110" else '0';--comp LFSRx4
en_comp(3)<='1' when switches="111" else '0';--comp LFSRx8
-- daca alegem modul square wave atunci Data Clock trebuie sa primeasca si el aceasi clk de 0.25
data_clk<=clk_sqr when switches="001" else clk_fltr;
end Behavioral;
