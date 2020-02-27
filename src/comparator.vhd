 library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL; 
entity comparator is   --comparator care compara suma introdusa cu costul biletului cu 3 iesiri+alte 2 si calculeaza biletele ramase si restul
	port(suma_introdusa,cost:in integer; --semnale de introducere
	mare,mic,egal:out std_logic:='0';	  --iesiri pentru teste
	vld_introducere,reset:in std_logic;	   --validare introducere si reset pentru rest
	--clk1: in std_logic_vector(26 downto 0);
	rest:out integer;							--iesire rest
	nr_bilete:out std_logic_vector(3 downto 0));	--iesire numar bilete
end entity ;

architecture descriere of comparator is
signal nr_blt:std_logic_vector(3 downto 0):="1001";		--semnal prentru contorizare bilete
begin
	proc2:	process(vld_introducere)
	variable restco:integer:=0;
	begin
		if vld_introducere='1' and vld_introducere'event then
		if suma_introdusa>cost then
			restco:=suma_introdusa-cost; 
			mare<='1';
			nr_blt<=nr_blt-1;
	    end if;
		if suma_introdusa=cost then
			egal<='1';
			nr_blt<=nr_blt-1;
		end if;
		if suma_introdusa<cost then
			mic<='1';
		end if;
		end if;
		if reset='1' then
			restco:=0;
		end if;
		rest<=restco;
		nr_bilete<=nr_blt;
	end process proc2;
end descriere;