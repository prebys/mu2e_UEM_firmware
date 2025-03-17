library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sumarea_module is
  port (
    rst : in std_logic;
    clk_a : in std_logic;
    inwr : in std_logic;
    startplus : in std_logic;
    
    datain_org0 : in std_logic_vector(15 downto 0);
    datain_org1 : in std_logic_vector(15 downto 0);
    datain_org2 : in std_logic_vector(15 downto 0);
    datain_org3 : in std_logic_vector(15 downto 0);
    ithr : in std_logic_vector(31 downto 0);

    inbusy : in std_logic;
    clk_b : in std_logic;

    wrdata : out std_logic;
    outevent_number : out std_logic_vector(31 downto 0);
    sumpeak_out : out std_logic_vector(31 downto 0);

    orst : out std_logic;
    owr_peak_sum : out std_logic;
    dout_sum : out std_logic_vector(31 downto 0);

    owr_peak_height : out std_logic;
    dout_height : out std_logic_vector(63 downto 0)
  );
end sumarea_module;

architecture Behavioral of sumarea_module is

  ---------------------------------------------------------------------------
  -- Retain your original enumerated states so the file structure is similar,
  -- but we’ll effectively remain in Idle and do nothing.
  ---------------------------------------------------------------------------
  type sumstate_t is (
    Idle,
    WaitCount,
    SendSum1,
    SendSum2,
    SendSum3,
    SendStrobeCheck,
    SendStrobe0,
    SendStrobe1,
    SendStrobe2,
    SendStrobe3,
    SendStrobe4,
    SendStrobe5,
    SendStrobe6
  );
  signal sumstate : sumstate_t;

begin

  ----------------------------------------------------------------------------
  -- Single process to keep the FSM “alive,” but it never leaves Idle.
  -- All outputs are forced to zero (or safe defaults).
  ----------------------------------------------------------------------------
  process(rst, clk_a)
  begin
    if rising_edge(clk_a) then
      if rst = '1' then
        sumstate <= Idle;

        -- Drive outputs to safe values
        wrdata           <= '0';
        outevent_number  <= (others => '0');
        sumpeak_out      <= (others => '0');
        orst             <= '0';
        owr_peak_sum     <= '0';
        dout_sum         <= (others => '0');
        owr_peak_height  <= '0';
        dout_height      <= (others => '0');

      else
        --------------------------------------------------------------------
        -- Because we stay in Idle unconditionally, we never do real work.
        --------------------------------------------------------------------
        case sumstate is

          when Idle =>
            sumstate <= Idle; -- do not transition
            wrdata           <= '0';
            outevent_number  <= (others => '0');
            sumpeak_out      <= (others => '0');
            orst             <= '0';
            owr_peak_sum     <= '0';
            dout_sum         <= (others => '0');
            owr_peak_height  <= '0';
            dout_height      <= (others => '0');

          when others =>
            -- Even if we did get here, drop back to Idle. 
            sumstate <= Idle;
            wrdata           <= '0';
            outevent_number  <= (others => '0');
            sumpeak_out      <= (others => '0');
            orst             <= '0';
            owr_peak_sum     <= '0';
            dout_sum         <= (others => '0');
            owr_peak_height  <= '0';
            dout_height      <= (others => '0');
        end case;
      end if;
    end if;
  end process;

end Behavioral;
