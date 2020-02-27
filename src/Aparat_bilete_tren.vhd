 library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity aparat_bilete is
	port(an:out std_logic_vector(3 downto 0);  --anozi
	cat:out std_logic_vector(6 downto 0);  --catozi
	led_mic,led_mare,led_egal:out std_logic:='0'; --iesiri comparator pentru verificare functionalitate(teste initiale)
	clka2,clkb2,clk:in std_logic; --clka2,clkb2 clock-ul de la numaratoare si clk clock-ul placii de 100Mhz(basys3)
	vld1,vld2,vld3,vld4,vld5,vld6:in std_logic; --validarii introducere bancnote si monede
	vld_introducere,vld_suma,vld_distanta,vld_afisare_bancnote,reset,bilete:in std_logic); --validari operatii
end entity;

architecture descriere_aparat of aparat_bilete is
	
component bcd7seg is
	port(an,qa3,qb3:out std_logic_vector(3 downto 0);
	cat:out std_logic_vector(6 downto 0); 
	nr1,nr2,nr1_suma,nr2_suma,nr1_banc,nr2_banc,nr_bilete:in std_logic_vector(3 downto 0);
	clka2,clkb2,clk,vld_distanta,vld_suma,vld_introducere,vld_afisare_bancnote,reset,bilete:in std_logic);
	--dp:out std_logic);
end component;  

component introducere_bancnote is
	port(
	suma_introdusa:out integer range 0 to 99;
	er1,er2,er5,er10,er20,er50:out integer;
	val1,val2,val3,val4,val5,val6,reset:in std_logic);
end component ;

component casa_bani is
	port(total_bani:out integer;
	er1,er2,er5,er10,er20,er50:in integer;
	eur1,eur2,eur5,eur10,eur20,eur50:out integer);
end component ;
	
component comparator is
	port(suma_introdusa,cost:in integer;
	mare,mic,egal:out std_logic;
	vld_introducere,reset:in std_logic;
	---clk1: in std_logic_vector(25 downto 0);
	rest:out integer;
	nr_bilete:out std_logic_vector(3 downto 0));
end component ;

component divizor_clk is
	port(clk:in std_logic;
	clk1:out std_logic_vector(30 downto 0));
end component ;	

component verificare_rest_bancnote is
	port( eur1,eur2,eur5,eur10,eur20,eur50:in integer;
	rest:in integer;
	clk1:in std_logic_vector(30 downto 0);
	vld_afisare_bancnote:in std_logic;	
	bancnota_afisare:out integer);
end component;

signal cost,suma_introdusa:integer;
signal qb2,nr1,nr2,qa1,qb1,nr1_suma,nr2_suma,nr1_banc,nr2_banc:std_logic_vector(3 downto 0);
signal total_bani_casa:integer;
signal rest:integer;
signal er1,er2,er5,er10,er20,er50: integer; --iesiri introducere bani pentru actualizare casa
signal eur1,eur2,eur5,eur10,eur20,eur50:integer;--iesire nr bancnote din casa de bani
signal clk1:std_logic_vector(30 downto 0);
signal bancnota_afisare: integer; 
signal nr_bilete:std_logic_vector(3 downto 0);

begin
	c1:bcd7seg port map(an,qa1,qb1,cat,nr1,nr2,nr1_suma,nr2_suma,nr1_banc,nr2_banc,nr_bilete,clka2,clkb2,clk,vld_distanta,vld_suma,vld_introducere,vld_afisare_bancnote,reset,bilete);
	c2:introducere_bancnote port map(suma_introdusa,er1,er2,er5,er10,er20,er50,vld1,vld2,vld3,vld4,vld5,vld6,reset);
	c3:casa_bani port map(total_bani_casa,er1,er2,er5,er10,er20,er50,eur1,eur2,eur5,eur10,eur20,eur50);
	c4:comparator port map(suma_introdusa,cost,led_mare,led_mic,led_egal,vld_introducere,reset,rest,nr_bilete);
	c5:verificare_rest_bancnote port map(er1,er2,er5,er10,er20,er50,rest,clk1,vld_afisare_bancnote,bancnota_afisare);
	c6:divizor_clk port map(clk,clk1);
	
	process(rest,reset)	 --proces pentru conversia restului in sir de biti, pentru afisarea pe afisor bcd 7 segmente
	variable rest_copie:integer:=rest;
	begin
		if rest/=integer'low then
		nr1 <= conv_std_logic_vector(rest mod 10,4);
		nr2 <= conv_std_logic_vector(rest_copie/10,4);
		end if;
	end process;
	
	process(vld1,vld2,vld3,vld4,vld5,vld6) --process pentru conversia sumei introduse, pentru afisarea pe afisor bcd 7 segmente
	variable sum_copie:integer:=suma_introdusa;
	begin 
		nr1_suma <= conv_std_logic_vector(suma_introdusa mod 10,4);
	    nr2_suma <= conv_std_logic_vector(sum_copie/10,4);
	end process;
	
	process(vld_suma) --proces care converteste 2 sirui de biti intr-un numar integer
	variable co1,co2,cost1:integer;
	begin	
		if vld_suma='1' and vld_suma'event then
		co1 := conv_integer(unsigned(qa1));
		co2 := conv_integer(unsigned(qb1));
		cost1:=co1+co2*10;
		cost<=cost1;
		end if;			
	end process; 
	
	process(clk1(26)) --proces care converteste bancnotele din integer in sir de biti pentru afiasrea pe afisor bcd 7 segmente
	begin  
		nr1_banc <= conv_std_logic_vector(bancnota_afisare mod 10,4);
	    nr2_banc <= conv_std_logic_vector(bancnota_afisare/10,4);
	end process;
		
		
	
			
	
	
	

end descriere_aparat;