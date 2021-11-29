------------------------------------------------------------------------------
-- internal_reset_timer.vhd - entity/architecture pair
--------- ---------------------------------------------------------------------
  
library ieee;
use ieee.std_logic_1164.all;

entity internal_reset_timer is
  generic
  (
   RESET_TIME                  : integer             := 100; -- clock pulses
   RESET_OUT_ACTIVE            : std_logic           := '0'; -- 0: reset_n, active low, 1: reset_h active high;
   RESET_IN_ACTIVE             : std_logic           := '0' -- 0: reset_n, active low, 1: reset_h active high;     
  );
  port
  (
    clock                   	: in std_logic 	:= '1';
    rst_in                   	: in std_logic 	:= '1';  -- RESET_IN_ACTIVE must be set to '0' if rst_in is left unconnected.
   -- rst_in                   	: in std_logic 	:= not RESET_IN_ACTIVE;     -- IP packager gir feilmeldingpå denne.
    rst_out                   	: out std_logic := '1'  
   );
end entity internal_reset_timer;

architecture IMP of internal_reset_timer is

constant RESET_IN_REG_LENGTH : integer  := 2;
 
signal reset_counter  	     : integer range RESET_TIME downto 0 := RESET_TIME;
signal reset_in_reg			: std_logic_vector(RESET_IN_REG_LENGTH-1 downto 0) := (others => RESET_IN_ACTIVE);
signal reset_in_latch 		: std_logic := RESET_IN_ACTIVE; 
signal reset_c 				: std_logic 	:= RESET_OUT_ACTIVE; 

begin

rst_out <= RESET_OUT_ACTIVE when reset_c = RESET_OUT_ACTIVE or reset_in_latch = RESET_IN_ACTIVE else (not RESET_OUT_ACTIVE);

reset_counter_process : process (clock,rst_in)
	begin
		if clock 'event and clock = '1' then 
			reset_in_reg <= reset_in_reg(RESET_IN_REG_LENGTH-2 downto 0) & reset_in_latch;
			if reset_in_reg(RESET_IN_REG_LENGTH-1) =  RESET_IN_ACTIVE then  
				reset_in_latch <= (not RESET_IN_ACTIVE);
				reset_counter <= RESET_TIME;
			end if;	 
			if reset_counter = 0 then 
				reset_c <= not RESET_OUT_ACTIVE;
			else
				reset_c <= RESET_OUT_ACTIVE;	
				reset_counter <= reset_counter -1;
			end if;
			if reset_in_reg(RESET_IN_REG_LENGTH-2) = RESET_IN_ACTIVE then 
				reset_counter <= RESET_TIME;
			end if;	 
		end if;
		if rst_in = RESET_IN_ACTIVE then
			reset_in_latch <= RESET_IN_ACTIVE;
		end if;	
	end process;
end IMP;
