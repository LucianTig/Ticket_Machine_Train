 library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL; 
entity bcd7seg is				  -- afisare date aparat de bilete
	port(an,qa3,qb3:out std_logic_vector(3 downto 0);  --qa3,qb3 iesiri numaratoare pentru conversie si calculare cost
	cat:out std_logic_vector(6 downto 0); 	 --catozi
	nr1,nr2,nr1_suma,nr2_suma,nr1_banc,nr2_banc,nr_bilete:in std_logic_vector(3 downto 0);	 --intrari diferite date pentru afisare
	clka2,clkb2,clk,vld_distanta,vld_suma,vld_introducere,vld_afisare_bancnote,reset,bilete:in std_logic); --clock-uri si validari
	--dp:out std_logic);
end bcd7seg; 

architecture afisare of bcd7seg is
component numarator_4bitia is
	port(
	qa:out std_logic_vector(3 downto 0);
	clka,reset:in std_logic);
end component numarator_4bitia;	 

component numarator_4bitib is
	port(
	qb:out std_logic_vector(3 downto 0);
		clkb,reset:in std_logic);
end component numarator_4bitib;

component debounce is
  port(	
    input  : IN  STD_LOGIC;  
    clk     : IN  STD_LOGIC; 
    output  : OUT STD_LOGIC); 
end component;

component divizor_clk is
	port(clk:in std_logic;
	clk1:out std_logic_vector(30 downto 0));
end component ;


signal qa1,qb1:std_logic_vector(3 downto 0);
signal clka1,clkb1:std_logic;
signal clk1:std_logic_vector(30 downto 0);

begin 
	C1: numarator_4bitia port map (qa1,clka1,reset);
    C2: numarator_4bitib port map (qb1,clkb1,reset);
	C3: debounce port map(clka2,clk,clka1);
	C4: debounce port map(clkb2,clk,clkb1);
	--C5: numarator_4bitib port map (qb2,clkb11);
	--C6: debounce port map(clkb3,clk,clkb11);
	C7: divizor_clk port map(clk,clk1);
	--dp<='1';
qa3<=qa1;
qb3<=qb1;
afisare1:process(clk)
begin 
	if bilete='0' then
	if vld_afisare_bancnote='0' then
   if vld_introducere='0' then
   if vld_suma='0' then
    if vld_distanta='0' then
	if clk1(15)='1' then
		an<="1110";
		case qa1 is
			when "0000"=>cat<="1000000";  --0
			when "0001"=>cat<="1111001";  --1
			when "0010"=>cat<="0100100";  --2
			when "0011"=>cat<="0110000";  --3
			when "0100"=>cat<="0011001";  --4
			when "0101"=>cat<="0010010";  --5
			when "0110"=>cat<="0000010";  --6
			when "0111"=>cat<="1111000";  --7
			when "1000"=>cat<="0000000";  --8
			when "1001"=>cat<="0010000";  --9 
			when others =>cat<="0000110"; --E
		end case; 
	else
		an<="1101";
		case qb1 is
			when "0000"=>cat<="1000000";  --0
			when "0001"=>cat<="1111001";  --1
			when "0010"=>cat<="0100100";  --2
			when "0011"=>cat<="0110000";  --3
			when "0100"=>cat<="0011001";  --4
			when "0101"=>cat<="0010010";  --5
			when "0110"=>cat<="0000010";  --6
			when "0111"=>cat<="1111000";  --7
			when "1000"=>cat<="0000000";  --8
			when "1001"=>cat<="0010000";  --9 
			when others =>cat<="0000110"; --E 
		end case;
	end if;
    else
	if clk1(15)='1' then
	  --  if (qa1/="1001" and qb1/="1001") then
	  --  if qb1="1001" then
	   --     qb11:=qb1+1;
	    --    qa11:=qa1+1;
	    --else
	    --    qa11:=qa1+1;
	   -- end if;
	    --end if;
	    
		an<="1011";
		case qa1 is
			when "0000"=>cat<="1000000";  --0
			when "0001"=>cat<="1111001";  --1
			when "0010"=>cat<="0100100";  --2
			when "0011"=>cat<="0110000";  --3
			when "0100"=>cat<="0011001";  --4
			when "0101"=>cat<="0010010";  --5
			when "0110"=>cat<="0000010";  --6
			when "0111"=>cat<="1111000";  --7
			when "1000"=>cat<="0000000";  --8
			when "1001"=>cat<="0010000";  --9 
			when others =>cat<="0000110"; --E
		end case; 
	else
		an<="0111";
		case qb1 is
			when "0000"=>cat<="1000000";  --0
			when "0001"=>cat<="1111001";  --1
			when "0010"=>cat<="0100100";  --2
			when "0011"=>cat<="0110000";  --3
			when "0100"=>cat<="0011001";  --4
			when "0101"=>cat<="0010010";  --5
			when "0110"=>cat<="0000010";  --6
			when "0111"=>cat<="1111000";  --7
			when "1000"=>cat<="0000000";  --8
			when "1001"=>cat<="0010000";  --9 
			when others =>cat<="0000110"; --E 
		end case;
	end if;
	end if;
	else
	if clk1(15)='1' then
            an<="1110";
            case nr1_suma is
                when "0000"=>cat<="1000000";  --0
                when "0001"=>cat<="1111001";  --1
                when "0010"=>cat<="0100100";  --2
                when "0011"=>cat<="0110000";  --3
                when "0100"=>cat<="0011001";  --4
                when "0101"=>cat<="0010010";  --5
                when "0110"=>cat<="0000010";  --6
                when "0111"=>cat<="1111000";  --7
                when "1000"=>cat<="0000000";  --8
                when "1001"=>cat<="0010000";  --9 
                when others =>cat<="0000110"; --E
            end case;
	else
		   an<="1101";
            case nr2_suma is
                when "0000"=>cat<="1000000";  --0
                when "0001"=>cat<="1111001";  --1
                when "0010"=>cat<="0100100";  --2
                when "0011"=>cat<="0110000";  --3
                when "0100"=>cat<="0011001";  --4
                when "0101"=>cat<="0010010";  --5
                when "0110"=>cat<="0000010";  --6
                when "0111"=>cat<="1111000";  --7
                when "1000"=>cat<="0000000";  --8
                when "1001"=>cat<="0010000";  --9  
                when others =>cat<="0000110"; --E
            end case;
		
    end if;
	end if;
	else 
		if clk1(15)='1' then
		an<="1011";
		case nr1 is
			when "0000"=>cat<="1000000";  --0
			when "0001"=>cat<="1111001";  --1
			when "0010"=>cat<="0100100";  --2
			when "0011"=>cat<="0110000";  --3
			when "0100"=>cat<="0011001";  --4
			when "0101"=>cat<="0010010";  --5
			when "0110"=>cat<="0000010";  --6
			when "0111"=>cat<="1111000";  --7
			when "1000"=>cat<="0000000";  --8
			when "1001"=>cat<="0010000";  --9  
			when others =>cat<="0000110"; --E
		end case; 
	else
		an<="0111";
		case nr2 is
			when "0000"=>cat<="1000000";  --0
			when "0001"=>cat<="1111001";  --1
			when "0010"=>cat<="0100100";  --2
			when "0011"=>cat<="0110000";  --3
			when "0100"=>cat<="0011001";  --4
			when "0101"=>cat<="0010010";  --5
			when "0110"=>cat<="0000010";  --6
			when "0111"=>cat<="1111000";  --7
			when "1000"=>cat<="0000000";  --8
			when "1001"=>cat<="0010000";  --9  	
			when others =>cat<="0000110"; --E 
		end case;
	end if;
	end if;
	else
		if clk1(15)='1' then
		an<="1110";
		case nr1_banc is
			when "0000"=>cat<="1000000";  --0
			when "0001"=>cat<="1111001";  --1
			when "0010"=>cat<="0100100";  --2
			when "0011"=>cat<="0110000";  --3
			when "0100"=>cat<="0011001";  --4
			when "0101"=>cat<="0010010";  --5
			when "0110"=>cat<="0000010";  --6
			when "0111"=>cat<="1111000";  --7
			when "1000"=>cat<="0000000";  --8
			when "1001"=>cat<="0010000";  --9 
			when others =>cat<="0000110"; --E
		end case; 
	else
		an<="1101";
		case nr2_banc is
			when "0000"=>cat<="1000000";  --0
			when "0001"=>cat<="1111001";  --1
			when "0010"=>cat<="0100100";  --2
			when "0011"=>cat<="0110000";  --3
			when "0100"=>cat<="0011001";  --4
			when "0101"=>cat<="0010010";  --5
			when "0110"=>cat<="0000010";  --6
			when "0111"=>cat<="1111000";  --7
			when "1000"=>cat<="0000000";  --8
			when "1001"=>cat<="0010000";  --9 
			when others =>cat<="0000110"; --E 
		end case;
	end if;
	end if;
    else
		if clk1(15)='1' then
		an<="1110";
		case nr_bilete is
			when "0000"=>cat<="1000000";  --0
			when "0001"=>cat<="1111001";  --1
			when "0010"=>cat<="0100100";  --2
			when "0011"=>cat<="0110000";  --3
			when "0100"=>cat<="0011001";  --4
			when "0101"=>cat<="0010010";  --5
			when "0110"=>cat<="0000010";  --6
			when "0111"=>cat<="1111000";  --7
			when "1000"=>cat<="0000000";  --8
			when "1001"=>cat<="0010000";  --9 
			when others =>cat<="0000110"; --E
		end case; 
	end if;
	end if;
		
		
	
	
end process afisare1;



	
end afisare;
		
			
			
			
			

