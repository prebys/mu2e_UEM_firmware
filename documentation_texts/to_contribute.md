### Things to try doing (if you're reading this!)
1. Follow the steps in [`README.md`](../README.md) and practice trying to take data
2. Try changing some of the parameters by doing in the minicomA window `poke cf000048 c8` while stream is off and then turn it back on and take new data. This will set the raw waveform window from 200ns to 400ns. See if it still takes data.
3. There is some kind of maximum amount of time allowed for the raw waveform window. If you set the setting too high, then all data stops coming, and even if you turn the setting back down, the data won't come until you completely reload the firmware from the original bit file. We need to investigate this. 

You can try any of these above things. Even just step one is a good starting point without worrying about any of the other things. 

Other to-do:

1. (I started this, see [this GitHub branch](https://github.com/prebys/mu2e_UEM_firmware/tree/minimal?tab=readme-ov-file)) Simplify GitHub project by expanding the .gitignore file. This will require Google searches + repeatedly cloning the GitHub repo and trying to build the .bit file from what just what the repo gives and see what files are necessary and what can be rebuilt. Obviously for example, not including the project file would break it, as would not including the .vhd source files, but I'm sure there are many files that are being included that aren't necessary. 


### How to use new ADC settings
1. Edit the settings in `/code/adc_trigger_settings.py`, reference [this page](https://github.com/prebys/mu2e_UEM_firmware/blob/main/documentation_texts/trigger_settings.md) and [this section on the main page](https://github.com/prebys/mu2e_UEM_firmware/tree/main?tab=readme-ov-file#configurable-bit-options-and-their-current-settings) for information on the trigger options.
2. Run with `python3 adc_trigger_settings.py`
3. Collect data the normal way
4. Plot the data file with `/socket/hex_check.py`

Things to investigate:
- The "trigger offset" variable 0x7fcad80, what happens if you increase or decrease it. (If it's too low you encounter an error in the code with infinite counting?)
- The mysterious events where it triggers off something but nothing shows. Maybe it's related to the external trigger? If you set trigger setting to 7f, it'll only trigger on external trigger. FE = only trigger on self triggers, and "00" = trigger on anything.

Testing the scopes
1. Set oscilloscope to 50 ohm setting, keep signal generator in "HighZ" setting.
2. Plug signal generator output into oscilloscope. We expect 50mV or 1V depending on our choice, but it's important to see what the signal generator shows. Maybe we'll be outputting 1V for example but the signal generator shows something very small, like 10mV or something.
3. Try changing the signal generator setting from "HighZ" to "50 Ohm" or something like that, see then if the oscilloscope reading matches the voltage you're giving it.
4. Once you've figured that out, put the signal back into the uTCA crate. Most likely, 50 ohm is what you want. Start out with small voltages (don't put anything above 1V into the uTCA crate to start). Plot the data that the uTCA crate receives, and see if it matches what you expect. If my suspicion is correct, the scaling will now be off and it'll read *higher* than what we're expecting. That's just an error in my Python code. Matthew seems to imply that the uTCA crate in reality only accepts signals within 1V.
