
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Generator_Medie is
    Port ( 
  clk,rst:in std_logic;
  Switches_dg,Switches_fl : in std_logic_vector(2 downto 0);
 anod:out STD_LOGIC_VECTOR (3 downto 0);
  catod:out STD_LOGIC_VECTOR (7 downto 0)
    );
end Generator_Medie;

architecture Behavioral of Generator_Medie is
component MPG is
    Port ( btn_in : in STD_LOGIC;
           clk : in STD_LOGIC;
           btn_out : out STD_LOGIC);
end component;
component Data_Generator is
 Port ( 
 clk,rst:in std_logic;
 switches:in std_logic_vector (2 downto 0);
 data:out std_logic_vector (7 downto 0);
 data_clk:out std_logic

 );
end component;

component Filter is
  Port (
  clk,rst:in std_logic;
  d_in:in std_logic_vector(7 downto 0);
  average:out std_logic_vector(7 downto 0);
  Switches:in std_logic_vector(2 downto 0)
   );
end component;

component Display is
  Port ( 
        clk:in std_logic;  
        reset:in std_logic;
        nr,avg:in std_logic_vector (7 downto 0);
        anod:out std_logic_vector (3 downto 0); 
        catod:out std_logic_vector (7 downto 0) 
    );
end component;
signal clk_div:std_logic;
signal data:std_logic_vector(7 downto 0);
signal average:std_logic_vector(7 downto 0);
signal rst_fltr:std_logic;
begin
DEB: MPG port map (rst,clk,rst_fltr);
DG: Data_Generator port map (clk,rst_fltr,Switches_dg,data,clk_div);
FL: Filter port map (clk_div,rst_fltr,data,average,Switches_fl);
DS: Display port map (clk,rst_fltr,data,average,anod,catod);
end Behavioral;
