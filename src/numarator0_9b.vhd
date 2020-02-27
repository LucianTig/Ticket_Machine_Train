library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity numarator_4bitib is	--numarator 0-9 pentru introducere date
	port(
	qb:out std_logic_vector(3 downto 0);    --iesire numarator
	clkb,reset:in std_logic);		        --clock numarator pus pe buton si reset numarator(asincron)
end numarator_4bitib;

architecture descriere of numarator_4bitib is
begin 
	process(clkb,reset)
	variable b:std_logic_vector(3 downto 0):="0000";  
	begin
		if reset='1' then
			b:="0000";
		elsif (clkb'event)and(clkb='1') then
			b:=b+1;
			if b>"1001" then
				b:="0000";
			end if;
		end if;
		qb<=b;
	end process; 
end descriere;