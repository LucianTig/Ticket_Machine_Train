 library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity verificare_rest_bancnote is
	port( eur1,eur2,eur5,eur10,eur20,eur50:in integer;	--intrari numar bancnote pentru dezvoltare ulterioara
	rest:in integer;									--intrare rest
	clk1:in std_logic_vector(30 downto 0);				--clock divizat
	vld_afisare_bancnote:in std_logic;					--validare afisare bancnote signal monede
	bancnota_afisare:out integer);						--iesire bancnota afisare pentru conversie si afisare pe afisor bcd 7 segmente
end verificare_rest_bancnote;

architecture descriere of verificare_rest_bancnote is 
begin 
	process(clk1(26)) 
	variable cst:integer;
	
	begin 
		if vld_afisare_bancnote='0' then
		cst:=rest;						
		elsif vld_afisare_bancnote='1' and clk1(26)'event and clk1(26)='1'  then
		case cst is
			when 50 to 99 => bancnota_afisare<=50;
			cst:=cst-50; 
			when 20 to 49 => bancnota_afisare<=20;
			cst:=cst-20;
			when 10 to 19 =>bancnota_afisare<=10;
			cst:=cst-10;
			when 5 to 9 =>bancnota_afisare<=5;
			cst:=cst-5;
			when 2 to 4 =>bancnota_afisare<=2;
			cst:=cst-2;
			when 1 =>bancnota_afisare<=1;
			cst:=cst-1;
			when 0=>bancnota_afisare<=0;
			when others =>bancnota_afisare<=0;
		end case;
		end if;	
		
		
		
	end process;
end descriere;
			
	
	