# tests/test_hex_check.py
import unittest
from python_analysis.hex_check_classes import *


class TestHexCheck(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        """Initialize hex_check once for all tests, only if not already set."""
        if "hex_check" not in hex_check_state:
            from python_analysis.hex_check import HexCheck, name_to_event as name_to_evt
            hex_check = HexCheck()
            hex_check.get_event_types(name_to_evt)
            hex_check_state["hex_check"] = hex_check

    def test_signed_12bit(self):
        self.assertEqual(signed(0x7FF, 12), 0x7FF)
        self.assertEqual(signed(0x800, 12), -0x800)

    def test_signed_16bit(self):
        self.assertEqual(signed(0x7FFF, 16), 0x7FFF)
        self.assertEqual(signed(0x8000, 16), -0x8000)

    def test_signed_32bit(self):
        self.assertEqual(signed(0x7FFFFFFF, 32), 0x7FFFFFFF)
        self.assertEqual(signed(0x80000000, 32), -0x80000000)

    def test_signed_invalid_width(self):
        with self.assertRaises(ValueError):
            signed(0b11111111111111111111111, 12)

    def test_process_s12(self):
        e = Event("f4f3f2f1", current_event_type=name_to_event["raw_data"])
        self.assertEqual(e.process_hex_raw_data(mode='s12'), DoubleADCTupleWithCount(-193, -225, 36))

        e2 = Event("78563412", current_event_type=name_to_event["raw_data"])
        self.assertEqual(e2.process_hex_raw_data(mode='s12'), DoubleADCTupleWithCount(1383, 291, 72))

    def test_process_s16(self):
        e = Event("f4f3f2f1", current_event_type=name_to_event["raw_data"])
        self.assertEqual(e.process_hex_raw_data(mode='s16'), DoubleADCTuple(-3084, -3598))

        e2 = Event("78563412", current_event_type=name_to_event["raw_data"])
        self.assertEqual(e2.process_hex_raw_data(mode='s16'), DoubleADCTuple(22136, 4660))

    def test_process_s32(self):
        e = Event("f4f3f2f1", current_event_type=name_to_event["raw_data"])
        self.assertEqual(e.process_hex_raw_data(mode='s32'), SingleADC(-235736076))

        e2 = Event("78563412", current_event_type=name_to_event["raw_data"])
        self.assertEqual(e2.process_hex_raw_data(mode='s32'), SingleADC(305419896))

    def test_event_data(self):
        self.assertEqual(Event("01000000", current_event_type=name_to_event["event_number_evn"]).data, 1)
        self.assertEqual(Event("ff0f0000", current_event_type=name_to_event["event_number_evn"]).data, 4095)
        self.assertEqual(Event("ffffffff", current_event_type=name_to_event["event_number_evn"]).data, 4294967295)


if __name__ == "__main__":
    unittest.main()
