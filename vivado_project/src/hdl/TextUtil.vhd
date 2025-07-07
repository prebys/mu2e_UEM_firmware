use std.textio.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- use work.common.all;

package TextUtil is
  procedure Print(s : string);          -- print
  procedure Print(s : string; debug_print : boolean); -- print with option to only work if debug_print = True
  procedure PrintT(s : string);         -- print with Time
  procedure PrintT(s : string; debug_print : boolean); -- print with Time
  function to_hstring(slv : std_logic_vector) return string;
  function to_int(v : unsigned) return string;
  function to_int(v : signed) return string;
end package TextUtil;

library ieee;
use ieee.std_logic_1164.all;

package body TextUtil is

  -- print a string
  procedure Print(s : string) is
    variable buf : line;
  begin
    write(buf, s);
    WriteLine(OUTPUT, buf);
  end procedure Print;

  -- print a string
  -- only prints if debug_print = True
  procedure Print(s : string; debug_print : boolean) is
    variable buf : line;
  begin
    if (debug_print) then
      write(buf, s);
      WriteLine(OUTPUT, buf);
    end if;
  end procedure Print;

  -- print a string with a prefix for the sim time
  procedure PrintT(s : string) is
    variable buf : line;
  begin
    --     write(buf, time'image(NOW));
    --    write(buf, NOW);
    write(buf, string'("["));
    write(buf, NOW, UNIT => ns);
    write(buf, string'("] "));
    write(buf, s);
    WriteLine(OUTPUT, buf);
  end procedure PrintT;

  -- print a string with a prefix for the sim time
  -- only prints if debug_print = True
  procedure PrintT(s : string; debug_print : boolean) is
    variable buf : line;
  begin
    if (debug_print) then
      write(buf, string'("["));
      write(buf, NOW, UNIT => ns);
      write(buf, string'("] "));
      write(buf, s);
      WriteLine(OUTPUT, buf);
    end if;
  end procedure PrintT;

  -- convert std_logic_vector to hex string
  function to_hstring(slv : std_logic_vector) return string is
    constant hexlen  : integer := (slv'length + 3) / 4;
    variable longslv : std_logic_vector(slv'length + 3 downto 0) := (others => '0');
    variable hex     : string(1 to hexlen);
    variable fourbit : std_logic_vector(3 downto 0);
  begin
    longslv(slv'length - 1 downto 0) := slv;
    for i in hexlen - 1 downto 0 loop
      fourbit := longslv(i * 4 + 3 downto i * 4);
      case fourbit is
        when "0000" => hex(hexlen - i) := '0';
        when "0001" => hex(hexlen - i) := '1';
        when "0010" => hex(hexlen - i) := '2';
        when "0011" => hex(hexlen - i) := '3';
        when "0100" => hex(hexlen - i) := '4';
        when "0101" => hex(hexlen - i) := '5';
        when "0110" => hex(hexlen - i) := '6';
        when "0111" => hex(hexlen - i) := '7';
        when "1000" => hex(hexlen - i) := '8';
        when "1001" => hex(hexlen - i) := '9';
        when "1010" => hex(hexlen - i) := 'A';
        when "1011" => hex(hexlen - i) := 'B';
        when "1100" => hex(hexlen - i) := 'C';
        when "1101" => hex(hexlen - i) := 'D';
        when "1110" => hex(hexlen - i) := 'E';
        when "1111" => hex(hexlen - i) := 'F';
        when "ZZZZ" => hex(hexlen - i) := 'Z';
        when "UUUU" => hex(hexlen - i) := 'U';
        when "XXXX" => hex(hexlen - i) := 'X';
        when others => hex(hexlen - i) := '?';
      end case;
    end loop;
    return hex;
  end function to_hstring;

  -- convert unsigned to int
  function to_int(v : unsigned) return string is
  begin
    return integer'image(to_integer(v));
  end function to_int;

  -- convert signed to int
  function to_int(v : signed) return string is
  begin
    return integer'image(to_integer(v));
  end function to_int;

end package body TextUtil;
