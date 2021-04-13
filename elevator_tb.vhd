LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY elevator_tb IS
END elevator_tb;

ARCHITECTURE test of elevator_tb IS
    COMPONENT elevator IS
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
    END COMPONENT;

    SIGNAL    nreset_t:     std_logic;
    SIGNAL    clk_t:        std_logic := '0';

    SIGNAL    come_t:       std_logic_vector(4 DOWNTO 1) := "0000";
    SIGNAL    switch_t:     std_logic_vector(4 DOWNTO 1) := "0001";
    SIGNAL    go_t:         std_logic_vector(4 DOWNTO 1) := "0000";  

    SIGNAL    motor_up_t:       std_logic;
    SIGNAL    motor_down_t:     std_logic;
    SIGNAL    current_floor_t:  std_logic_vector(1 DOWNTO 0);
    SIGNAL    move_state_t:     std_logic_vector(1 DOWNTO 0);
    
BEGIN
    u1: elevator PORT MAP(nreset_t, clk_t, come_t, switch_t, go_t, motor_up_t, motor_down_t, current_floor_t, move_state_t);

    clk_t <= '1' AFTER 1 ns WHEN clk_t <= '0' ELSE '0' AFTER 1 ns;

    PROCESS BEGIN

        -- nreset_t <= '0';
        -- WAIT FOR 10 ns;
        
        -- nreset_t <= '1';
        -- WAIT FOR 10 ns;

        -- come_t <= "1000";
        -- WAIT FOR 10 ns;

        -- come_t <= "0101";
        -- WAIT FOR 10 ns;





        nreset_t <= '0';
        WAIT FOR 5 ns;
        
        nreset_t <= '1';
        WAIT FOR 5 ns;

        go_t <= "0011";
        come_t <= "1000";
        WAIT FOR 10 ns;
        switch_t <= "0001";
        WAIT FOR 10 ns;
        go_t <= "0010";
        come_t <= "1000";
        WAIT FOR 10 ns;
        switch_t <= "0010";
        go_t <= "0000";
        come_t <= "1000";
        WAIT FOR 10 ns;
        switch_t <= "0100";
        WAIT FOR 10 ns;
        switch_t <= "1000";
        WAIT FOR 10 ns;
        go_t <= "0010";
        come_t <= "0000";
        WAIT FOR 10 ns;
        switch_t <= "0100";
        WAIT FOR 10 ns;
        switch_t <= "0010";
        go_t <= "1100";
        come_t <= "0011";
        WAIT FOR 10 ns;
        go_t <= "1100";
        come_t <= "0001";
        WAIT FOR 10 ns;
        switch_t <= "0100";
        WAIT FOR 10 ns;
        go_t <= "1000";
        WAIT FOR 10 ns;
        switch_t <= "1000";
        WAIT FOR 10 ns;
        go_t <= "0000";
        WAIT FOR 10 ns;
        switch_t <= "0100";
        WAIT FOR 10 ns;
        switch_t <= "0010";
        WAIT FOR 10 ns;
        switch_t <= "0001";
        WAIT FOR 10 ns;




        nreset_t <= '0';
        come_t <= "0000";
        go_t <= "0000";
        switch_t <= "0001";
		WAIT FOR 10 ns;

        nreset_t <= '1';
		WAIT FOR 10 ns;

        go_t <= "0100";
		WAIT FOR 10 ns;
        
        switch_t <= "0010";
		WAIT FOR 10 ns;

        WAIT FOR 10 ns;
        switch_t <= "0100";
        WAIT FOR 10 ns;

		come_t <= "1000";
		go_t <= "0000";
        WAIT FOR 10 ns;

        switch_t <= "1000";
        WAIT FOR 10 ns;

		go_t <= "0000";
		come_t <= "0001";
		WAIT FOR 2 ns;
		go_t <= "1000";
        come_t <= "0000";   
		WAIT FOR 8 ns;


		WAIT FOR 10 ns;
		go_t <= "0100";
		come_t <= "0010";
        WAIT FOR 10 ns;
        switch_t <= "0100";
        WAIT FOR 10 ns;
        go_t <= "0000";
        WAIT FOR 10 ns;
        switch_t <= "0010";
        WAIT FOR 10 ns;


        -- nreset_t <= '0';
        -- WAIT FOR 10 ns;
        

        -- come_t <= "0000";
        -- go_t <= "0000";
        -- WAIT FOR 10 ns;
        -- nreset_t <= '1';
        -- WAIT FOR 10 ns;
        -- come_t <= "0110";
        -- go_t <= "0000";
        -- WAIT FOR 10 ns;
        WAIT;
    END PROCESS;


END test;
