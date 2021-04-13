LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY elevator IS 
    PORT(
        nreset:     IN std_logic;
        clk:        IN std_logic;

        come:       IN std_logic_vector(4 DOWNTO 1);
        switch:     IN std_logic_vector(4 DOWNTO 1);
        go:         IN std_logic_vector(4 DOWNTO 1);

        motor_up:       OUT std_logic;
        motor_down:     OUT std_logic;
        current_floor:  OUT std_logic_vector(1 DOWNTO 0);
        move_state:     OUT std_logic_vector(1 DOWNTO 0)
    );
END elevator;

ARCHITECTURE moore_behaviroal OF elevator IS
    TYPE state IS (s1, s2, s3, s4, s1u, s2u, s2d, s3u, s3d, s4d);
    SIGNAL current_state, next_state: state;
    SIGNAL move_state_temp : std_logic_vector(1 DOWNTO 0);
    SIGNAL fin : std_logic_vector(4 DOWNTO 1); 


    -- move_state : 00 : steady , 01 : up , 10 : down
    -- current_floor : 00 : 4 , 01 : 1 , 10 : 2 , 11 : 3 

BEGIN

    -- PROCESS(go, come, nreset) BEGIN
    --     IF nreset = '0' THEN
    --         fin <= "0000";
    --     ELSE
    --         fin <= fin OR come;
    --         fin <= fin OR go;
    --         IF current_state = s1 OR current_state = s1u THEN
    --             fin(1) <= '0';
    --         ELSIF  current_state = s2 OR current_state = s2u OR current_state = s2d THEN
    --             fin(2) <= '0';
    --         ELSIF  current_state = s3 OR current_state = s3u OR current_state = s3d THEN
    --             fin(3) <= '0';
    --         ELSIF  current_state = s4 OR current_state = s4d THEN
    --             fin(4) <= '0';
    --         END IF; 
    --     END IF;
    -- END PROCESS;

    fin <= go OR come;


    PROCESS(fin, current_state, switch) BEGIN
    -- IF clk = '1' AND clk'EVENT THEN
        IF current_state = s1 THEN
            IF NOT (fin(1) = '1' OR fin = "0000") THEN
                next_state <= s1u;
            ELSIF switch(1) = '1' THEN 
                next_state <= s1;
            END IF;


        ELSIF current_state = s2 THEN
            IF NOT (fin(2) = '1' OR fin = "0000") THEN
                IF fin = "1100" OR fin = "0100" OR fin = "1000" OR fin = "0101" OR fin = "1101"  THEN
                    next_state <= s2u;
                ELSIF fin = "0001" OR fin = "1001" THEN
                    next_state <= s2d;
                END IF;
            ELSIF switch(2) = '1' THEN
                next_state <= s2;
            END IF;

        ELSIF current_state = s3 THEN
            IF NOT (fin(3) = '1' OR fin = "0000") THEN
                IF fin = "1000" OR fin = "1001" OR fin = "1010" THEN
                    next_state <= s3u;
                ELSIF fin = "0001" OR fin = "0010" OR fin = "0011" OR fin = "1011" THEN
                    next_state <= s3d;
                END IF;
            ELSIF switch(3) = '1' THEN
                next_state <= s3;
            END IF;

        ELSIF current_state = s4 THEN
            IF NOT (fin(4) = '1' OR fin = "0000") THEN
                next_state <= s4d;
            ELSIF switch(4) = '1' THEN
                next_state <= s4;
            END IF;

        ELSIF current_state = s1u THEN
            IF switch(2) = '1' THEN
                IF fin(2) = '1' THEN
                    next_state <= s2;
                ELSIF fin(3) = '1' OR fin(4) = '1' THEN
                    next_state <= s2u;
                ELSE
                    next_state <= s2;
                END IF;
            END IF;

        ELSIF current_state = s2u THEN
            IF switch(3) = '1' THEN
                IF fin(3) = '1' THEN
                    next_state <= s3;
                ELSIF fin(4) = '1' THEN
                    next_state <= s3u;
                ELSE 
                    next_state <= s3;
                END IF;
            END IF;
        ELSIF current_state = s2d THEN
            IF switch(1) = '1' THEN
                next_state <= s1;
            --     IF fin(1) = '1' THEN
            --         next_state <= s1;
            --     ELSE
            --         next_state <= s1;
            --     END IF;
            END IF;

        ELSIF current_state = s3u THEN
            IF switch(4) = '1' THEN
                next_state <= s4;
                -- IF fin(4) = '1' THEN
                --     next_state <= s4;
                -- ELSE
                --     next_state <= s4;
                -- END IF;
            END IF;
        ELSIF current_state = s3d THEN
            IF switch(2) = '1' THEN
                IF fin(2) = '1' THEN
                    next_state <= s2;
                ELSIF fin(1) = '1' THEN
                    next_state <= s2d;
                ELSE
                    next_state <= s2;
                END IF;
            END IF;

        ELSIF current_state = s4d THEN
            IF switch(3) = '1' THEN
                IF fin(3) = '1' THEN
                    next_state <= s3;
                ELSIF fin(2) = '1' OR fin(1) = '1' THEN
                    next_state <= s3d;
                ELSE
                    next_state <= s3;
                END IF;
            END IF;
        END IF;
    -- END IF;    

    END PROCESS;

    
    PROCESS(nreset, clk) BEGIN
    IF nreset = '0' THEN 
        move_state <= "00";
        current_floor <= "01";
        motor_up <= '0';
        motor_down <= '0';
    ELSIF clk = '1' AND clk'EVENT THEN 
        IF next_state = s1 THEN
            move_state <= "00";
            current_floor <= "01";
            motor_up <= '0';
            motor_down <= '0';
        ELSIF next_state = s2 THEN
            move_state <= "00";
            current_floor <= "10";
            motor_up <= '0';
            motor_down <= '0';
        ELSIF next_state = s3 THEN
            move_state <= "00";
            current_floor <= "11";
            motor_up <= '0';
            motor_down <= '0';
        ELSIF next_state = s4 THEN
            move_state <= "00";
            current_floor <= "00";
            motor_up <= '0';
            motor_down <= '0';
        ELSIF next_state = s1u THEN
            current_floor <= "01";
            move_state <= "01";
            motor_up <= '1';
            motor_down <= '0';
        ELSIF next_state = s2u THEN
            current_floor <= "10";
            move_state <= "01";
            motor_up <= '1';
            motor_down <= '0';
        ELSIF next_state = s2d THEN
            current_floor <= "10";
            move_state <= "10";
            motor_up <= '0';
            motor_down <= '1';
        ELSIF next_state = s3u THEN
            current_floor <= "11";
            move_state <= "01";
            motor_up <= '1';
            motor_down <= '0';
        ELSIF next_state = s3d THEN
            current_floor <= "11";
            move_state <= "10";
            motor_up <= '0';
            motor_down <= '1';
        ELSIF next_state = s4d THEN
            current_floor <= "00";
            move_state <= "10";
            motor_up <= '0';
            motor_down <= '1';
        END IF;
    END IF;
    END PROCESS;



    PROCESS(nreset, clk) BEGIN 
        IF nreset = '0' THEN 
            current_state <= s1;
        ELSIF clk = '1' AND clk'EVENT THEN 
            current_state <= next_state;
        END IF;
    END PROCESS;

END moore_behaviroal;

