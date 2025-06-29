

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.Types.all;

entity Filter is
  Port (
  clk,rst:in std_logic;
  d_in:in std_logic_vector(7 downto 0);
  average:out std_logic_vector(7 downto 0);
  Switches:in std_logic_vector(2 downto 0)
   );
end Filter;

architecture Behavioral of Filter is


component Avg16Samples is
  Port (
 rst,full:in  std_logic;
    y : in  matrice;
    avg_out : out std_logic_vector(7 downto 0)  
    );
end component;

component Avg8Samples is
   Port (
 rst,full:in  std_logic;
    y : in  matrice;
    avg_out : out std_logic_vector(7 downto 0)  
    );
end component;

component Avg4Samples is
  Port (
 rst,full:in  std_logic;
    y : in  matrice;
    avg_out : out std_logic_vector(7 downto 0)  
    );
end component;

component Avg2Samples is
  Port (
 rst,full:in  std_logic;
    y : in  matrice;
    avg_out : out std_logic_vector(7 downto 0)  
    );
end component;

component TestMode is
     Port (
   clk, rst : in std_logic;
    sw :in std_logic_vector(2 downto 0);
    x   : in std_logic_vector(7 downto 0);
    y   : out std_logic_vector(7 downto 0)
  );
end component;

component Buff is
   Port (
    clk, rst, en:in std_logic;
    d_in:in std_logic_vector(7 downto 0);
    y:out matrice ;
    full: out std_logic_vector(3 downto 0)
  );
end component;

component Mux8 is
 Port (
  sel:in std_logic_vector (2 downto 0);
   d0,d1,d2,d3,d4,d5,d6,d7:in std_logic_vector(7 downto 0);
    y:out std_logic_vector(7 downto 0)
  );
end component;


signal av_temp:matrice;
signal full:std_logic_vector(3 downto 0);
signal y : matrice;
signal en:std_logic;
signal temp:std_logic_vector(7 downto 0);
begin
buf: Buff port map (clk,rst,en,d_in,y,full);
test: TestMode port map (clk,rst,Switches,temp,av_temp(0));
avg2: Avg2Samples port map (rst,full(0),y,av_temp(4));
avg4: Avg4Samples port map (rst,full(1),y,av_temp(5));
avg8: Avg8Samples port map (rst,full(2),y,av_temp(6));
avg16: Avg16Samples port map (rst,full(3),y,av_temp(7));
mux: Mux8 port map (Switches,av_temp(0),av_temp(0),av_temp(0),av_temp(0),av_temp(4),av_temp(5),av_temp(6),av_temp(7),temp);
with Switches select
    en <= '1' when "100",
          '1' when "101",
          '1' when "110",
          '1' when "111",
          '0' when others;
average<=temp;
end Behavioral;
