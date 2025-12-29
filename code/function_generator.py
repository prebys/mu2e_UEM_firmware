#!/usr/bin/env python3
"""
Rigol DG832 helper:

- Without args:
    python3 function_generator.py
  -> queries CH1 & CH2, prints JSON, saves to dg832_config_<timestamp>.json

- With a JSON config file:
    python3 function_generator.py path/to/config.json
  -> loads CH1/CH2 settings from file, applies them to the DG832,
     then re-queries and saves a new snapshot.
"""

import sys
import json
import datetime
import usbtmc

VID = 0x1ab1
PID = 0x0643

# set to True if you wish this program to save a snapshot of final settings
save_new_snapshot = False

# ---------------- basic USBTMC helpers ----------------

def connect():
    inst = usbtmc.Instrument(VID, PID)
    inst.timeout = 2.0   # seconds
    return inst

def ask(inst, cmd, strip=True):
    try:
        resp = inst.ask(cmd)
        return resp.strip() if strip else resp
    except Exception as e:
        return f"N/A ({type(e).__name__})"

def write(inst, cmd):
    try:
        inst.write(cmd)
        # print(f"> {cmd}")   # uncomment for verbose logging
        return True
    except Exception:
        return False

# ---------------- helpers for applying settings ----------------

def _float_or_none(value):
    """Convert string like '1.000000E+03' to float, but keep N/A etc. as None."""
    if value is None:
        return None
    if isinstance(value, (int, float)):
        return float(value)
    s = str(value).strip()
    if s == "" or s.startswith("N/A"):
        return None
    try:
        return float(s)
    except Exception:
        return None

def _scpi_bool(v):
    if isinstance(v, bool):
        return 'ON' if v else 'OFF'
    s = str(v).strip().upper()
    if s in ('ON', '1', 'TRUE'):
        return 'ON'
    return 'OFF'

def _norm_func(name):
    if not name:
        return None
    s = str(name).upper().strip()
    mapping = {
        'SIN': 'SIN', 'SINE': 'SIN', 'SINUSOID': 'SIN',
        'SQU': 'SQU', 'SQUARE': 'SQU',
        'RAMP': 'RAMP',
        'PULS': 'PULS', 'PULSE': 'PULS',
        'NOIS': 'NOIS', 'NOISE': 'NOIS',
        'DC': 'DC',
        'USER': 'USER', 'ARB': 'USER', 'ARBITRARY': 'USER',
    }
    return mapping.get(s, s)

def apply_channel_settings(inst, ch: int, settings: dict):
    """Apply a settings dict to channel ch.

    Expected keys (all optional):
      func, freq, volt, unit, offset, phase, high, low,
      output, load, duty, pulse_width, rise, fall
    """
    if not settings:
        return

    P = lambda suffix: f"SOUR{ch}:{suffix}"
    O = lambda suffix="": f"OUTP{ch}{suffix}"

    s = {k.lower(): v for k, v in settings.items() if v is not None}

    # Function first
    if 'func' in s:
        fn = _norm_func(s['func'])
        if fn:
            write(inst, P(f"FUNC {fn}"))

    # Units (VPP/VRMS) before amplitude
    if 'unit' in s:
        unit = str(s['unit']).upper()
        if unit in ('VPP', 'VRMS'):
            write(inst, P(f"VOLT:UNIT {unit}"))

    # Core numeric settings
    if 'freq' in s:
        write(inst, P(f"FREQ {s['freq']}"))
    if 'volt' in s:
        write(inst, P(f"VOLT {s['volt']}"))
    if 'offset' in s:
        write(inst, P(f"VOLT:OFFS {s['offset']}"))
    if 'phase' in s:
        write(inst, P(f"PHAS {s['phase']}"))

    # High/Low levels
    if 'high' in s:
        write(inst, P(f"VOLT:HIGH {s['high']}"))
    if 'low' in s:
        write(inst, P(f"VOLT:LOW {s['low']}"))

    # Load
    if 'load' in s:
        val = s['load']
        if isinstance(val, (int, float)):
            write(inst, O(f":LOAD {val}"))
        else:
            write(inst, O(f":LOAD {str(val).upper()}"))

    # Function-specific
    if 'duty' in s:
        write(inst, P(f"SQU:DCYC {s['duty']}"))
        write(inst, P(f"PULS:DCYC {s['duty']}"))
    if 'pulse_width' in s:
        write(inst, P(f"PULS:WIDT {s['pulse_width']}"))
    if 'rise' in s:
        write(inst, P(f"PULS:TRAN:LEAD {s['rise']}"))
    if 'fall' in s:
        write(inst, P(f"PULS:TRAN:TRA {s['fall']}"))

    # Output last
    if 'output' in s:
        write(inst, f"OUTP{ch} {_scpi_bool(s['output'])}")

# ---------------- mapping from saved JSON -> settings dict ----------------

def settings_from_dump(d: dict) -> dict:
    """Convert a channel dump (CH1/CH2 from JSON file) into a settings dict."""
    if not d:
        return {}

    s = {}

    # func
    func = d.get("FUNC")
    if func and not str(func).startswith("N/A"):
        s['func'] = func

    # core numeric
    freq = _float_or_none(d.get("FREQ"))
    volt = _float_or_none(d.get("VOLT"))
    offs = _float_or_none(d.get("VOLT:OFFS"))
    phase = _float_or_none(d.get("PHAS"))
    vhigh = _float_or_none(d.get("VOLT:HIGH"))
    vlow  = _float_or_none(d.get("VOLT:LOW"))

    if freq is not None:
        s['freq'] = freq
    if volt is not None:
        s['volt'] = volt
    if offs is not None:
        s['offset'] = offs
    if phase is not None:
        s['phase'] = phase
    if vhigh is not None:
        s['high'] = vhigh
    if vlow is not None:
        s['low'] = vlow

    # units
    unit = d.get("VOLT:UNIT")
    if unit and not str(unit).startswith("N/A"):
        s['unit'] = unit

    # output ON/OFF
    outp = d.get("OUTP")
    if outp and not str(outp).startswith("N/A"):
        s['output'] = (str(outp).strip().upper() in ("ON", "1"))

    # load
    load_raw = d.get("OUTP:LOAD")
    if load_raw and not str(load_raw).startswith("N/A"):
        # Try numeric, else leave as symbolic string (e.g., INF)
        load_val = _float_or_none(load_raw)
        s['load'] = load_val if load_val is not None else str(load_raw).strip()

    # duty from pulse or square
    duty_p = _float_or_none(d.get("PULSE:DCYC"))
    duty_s = _float_or_none(d.get("SQU:DCYC"))
    duty = duty_p if duty_p is not None else duty_s
    if duty is not None:
        s['duty'] = duty

    # pulse width / edges
    pw   = _float_or_none(d.get("PULSE:WIDT"))
    rise = _float_or_none(d.get("PULSE:TRAN:LEAD"))
    fall = _float_or_none(d.get("PULSE:TRAN:TRA"))
    if pw is not None:
        s['pulse_width'] = pw
    if rise is not None:
        s['rise'] = rise
    if fall is not None:
        s['fall'] = fall

    return s

# ---------------- querying current config ----------------

def query_channel(inst, ch: int) -> dict:
    P = lambda suffix: f"SOUR{ch}:{suffix}"
    O = lambda suffix="": f"OUTP{ch}{suffix}"

    data = {}
    data["APPL?"]      = ask(inst, P("APPL?"))
    data["FUNC"]       = ask(inst, P("FUNC?"))
    data["FREQ"]       = ask(inst, P("FREQ?"))
    data["VOLT"]       = ask(inst, P("VOLT?"))
    data["VOLT:UNIT"]  = ask(inst, P("VOLT:UNIT?"))
    data["VOLT:OFFS"]  = ask(inst, P("VOLT:OFFS?"))
    data["PHAS"]       = ask(inst, P("PHAS?"))
    data["VOLT:HIGH"]  = ask(inst, P("VOLT:HIGH?"))
    data["VOLT:LOW"]   = ask(inst, P("VOLT:LOW?"))

    # Output state – OUTP{ch}? returns ON/OFF on your unit
    raw_outp = ask(inst, f"OUTP{ch}?")
    if raw_outp.startswith("N/A"):
        data["OUTP_RAW"] = raw_outp
        data["OUTP"] = "UNKNOWN"
    else:
        s = raw_outp.strip().upper()
        data["OUTP_RAW"] = raw_outp
        data["OUTP"] = "ON" if s in ("ON", "1") else "OFF"

    data["OUTP:LOAD"]  = ask(inst, O(":LOAD?"))

    data["PULSE:DCYC"]      = ask(inst, P("PULS:DCYC?"))
    data["PULSE:WIDT"]      = ask(inst, P("PULS:WIDT?"))
    data["PULSE:TRAN:LEAD"] = ask(inst, P("PULS:TRAN:LEAD?"))
    data["PULSE:TRAN:TRA"]  = ask(inst, P("PULS:TRAN:TRA?"))
    data["SQU:DCYC"]        = ask(inst, P("SQU:DCYC?"))

    return data

# ---------------- main ----------------

def main():
    # Optional config file argument
    config_path = sys.argv[1] if len(sys.argv) > 1 else None

    try:
        inst = connect()
    except Exception as e:
        print(f"ERROR: Could not open USBTMC instrument {hex(VID)}:{hex(PID)}: {e}", file=sys.stderr)
        sys.exit(1)

    info = {}
    info["*IDN?"] = ask(inst, "*IDN?")

    # If a config file was specified, load it and apply CH1/CH2
    if config_path:
        try:
            with open(config_path, "r") as f:
                cfg = json.load(f)
            ch1_cfg = cfg.get("CH1", {})
            ch2_cfg = cfg.get("CH2", {})
            ch1_settings = settings_from_dump(ch1_cfg)
            ch2_settings = settings_from_dump(ch2_cfg)
            print(f"Applying settings from {config_path} ...")
            apply_channel_settings(inst, 1, ch1_settings)
            apply_channel_settings(inst, 2, ch2_settings)
        except Exception as e:
            print(f"WARNING: Failed to load/apply config from {config_path}: {e}", file=sys.stderr)

    # Always query current state after (maybe) applying settings
    info["CH1"] = query_channel(inst, 1)
    info["CH2"] = query_channel(inst, 2)

    # Print and save
    json_text = json.dumps(info, indent=2, sort_keys=False)
    print(json_text)

    timestamp = datetime.datetime.now().strftime("%Y%m%d_%H%M%S")
    filename = f"dg832_config_{timestamp}.json"

    if save_new_snapshot:
        try:
            with open(filename, "w") as f:
                f.write(json_text)
            print(f"\nConfiguration saved to: {filename}")
        except OSError as e:
            print(f"\nWARNING: Could not save JSON to file {filename}: {e}", file=sys.stderr)

if __name__ == "__main__":
    main()

