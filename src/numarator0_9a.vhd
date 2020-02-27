library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity numarator_4bitia is	 --numarator 0-9 pentru introducere date
	port(
	qa:out std_logic_vector(3 downto 0);  --iesire numarator
	clka,reset:in std_logic);			  --clock numarator pus pe buton si reset numarator(asincron)
end numarator_4bitia;

architecture descriere of numarator_4bitia is
begin 
	process(clka,reset)
	variable b:std_logic_vector(3 downto 0):="0000";  
	begin
		if reset='1' then
			b:="0000";
		elsif (clka'event)and(clka='1') then
			b:=b+1;
			if b>"1001" then
				b:="0000";
			end if;
		end if;
		qa<=b;
	end process; 
end descriere;