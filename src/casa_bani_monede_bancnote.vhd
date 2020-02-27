 library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity casa_bani is		--casa bani initializata si actualizata la momentul introducerii banilor
	port(total_bani:out integer;		 --implementare initiala(modificata ulterior) 
	er1,er2,er5,er10,er20,er50:in integer;	 --intrari bancnote
    eur1,eur2,eur5,eur10,eur20,eur50:out integer); --iesiri bancnote si monede din casa
end entity ; 

architecture descriere of casa_bani is 
begin
	eur1<=1+er1;
	eur2<=1+er2;
	eur5<=1+er5;
	eur10<=1+er10; 
	eur20<=1+er20;
	eur50<=1+er50;
end descriere;	  

	