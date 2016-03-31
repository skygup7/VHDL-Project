LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
 
ENTITY AC_REMOTE IS
    PORT(
        TEMPERATURE: OUT STD_LOGIC_VECTOR (5 DOWNTO 0);
        FANSPEED: OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
          CLOCK: IN STD_LOGIC;
        RESET: IN STD_LOGIC;
        TEMPUP: IN STD_LOGIC;
        TEMPDOWN: IN STD_LOGIC;
        FANUP: IN STD_LOGIC;
        FANDOWN: IN STD_LOGIC
    );
END AC_REMOTE;
 
ARCHITECTURE LOGIC OF AC_REMOTE IS
 
BEGIN
   
    CHANGE : PROCESS (CLOCK) IS
    VARIABLE TEMPERATURE_STORAGE : INTEGER;
    VARIABLE FANSPEED_STORAGE : INTEGER;
   
    BEGIN
     IF (RISING_EDGE(CLOCK)) THEN
        IF (RESET = '1') THEN
            TEMPERATURE_STORAGE := 25;
            FANSPEED_STORAGE := 2;    
       
        ELSIF (TEMPUP = '1' AND TEMPERATURE_STORAGE < 36)THEN
            TEMPERATURE_STORAGE :=TEMPERATURE_STORAGE + 1;
           
        ELSIF (TEMPDOWN = '1' AND TEMPERATURE_STORAGE > 16) THEN
            TEMPERATURE_STORAGE := TEMPERATURE_STORAGE - 1;
       
        ELSIF (FANUP = '1' AND FANSPEED_STORAGE < 3) THEN
            FANSPEED_STORAGE := FANSPEED_STORAGE + 1;
           
        ELSIF (FANDOWN = '1' AND FANSPEED_STORAGE > 1) THEN
            FANSPEED_STORAGE := FANSPEED_STORAGE - 1;
           
        END IF;
       
        TEMPERATURE <= CONV_STD_LOGIC_VECTOR(TEMPERATURE_STORAGE,6) AFTER 1 NS;
        FANSPEED <= CONV_STD_LOGIC_VECTOR (FANSPEED_STORAGE,2) AFTER 1 NS;
    END IF;  
    END PROCESS CHANGE;
 
END LOGIC;