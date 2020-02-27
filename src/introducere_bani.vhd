 library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL; 
entity introducere_bancnote is			   --calculare suma introdusa si bancnote,monede
	port(
	suma_introdusa:out integer range 0 to 99;  --suma introdusa penrtu conversie si afisare 
	er1,er2,er5,er10,er20,er50:out integer;	 --iesiri pentru actualizare casa de bani
	val1,val2,val3,val4,val5,val6,reset:in std_logic);	 --validari bancnote si monede
end introducere_bancnote ;


architecture descriere of introducere_bancnote is
begin  
	process(val1,val2,val3,val4,val5,val6,reset)
	variable sum1,sum2,sum3,sum4,sum5,sum6:integer:=0;
begin
	if val1='1' and val1'event then
		sum1:=sum1+1;
	end if;
	if val2='1' and val2'event then
		sum2:=sum2+2;
	end if;
	if val3='1' and val3'event then
		sum3:=sum3+5;
	end if;
	if val4='1' and val4'event then
		sum4:=sum4+10;
	end if;
	if val5='1' and val5'event then
		sum5:=sum5+20; 
	end if;
	if val6='1' and val6'event then 
		sum6:=sum6+50;
	end if;
	if reset='1' then
		sum1:=0;
		sum2:=0;
		sum3:=0;
		sum4:=0;
		sum5:=0;
		sum6:=0;
		suma_introdusa<=0;
	else
		suma_introdusa<=sum1+sum2+sum3+sum4+sum5+sum6;
	end if;
			
er1<=sum1;
er2<=sum2;
er5<=sum3;
er10<=sum4;
er20<=sum5;
er50<=sum6;

end process;
end descriere ;
			