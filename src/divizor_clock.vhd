 library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL; 
entity divizor_clk is	  --divizor de clock
	port(clk:in std_logic;	 --clock-ul placi de 100 Mhz pe basys3
	clk1:out std_logic_vector(30 downto 0));   --vector de biti pentru divizare(facut de 31 de biti pentru diferite test)
end entity ;

architecture descriere of divizor_clk is
signal clk2:std_logic_vector(30 downto 0);
begin 
	divizare: process(clk)
begin
	if clk'event and clk='1' then
		clk2<=clk2+1;
	end if;
	clk1<=clk2;
end process divizare;
end descriere;

	