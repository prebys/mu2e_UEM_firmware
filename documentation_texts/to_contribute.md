### Things to try doing (if you're reading this!)
1. Follow the steps in [`README.md`](../README.md) and practice trying to take data
2. Try changing some of the parameters by doing in the minicomA window `poke cf000048 c8` while stream is off and then turn it back on and take new data. This will set the raw waveform window from 200ns to 400ns. See if it still takes data.
3. There is some kind of maximum amount of time allowed for the raw waveform window. If you set the setting too high, then all data stops coming, and even if you turn the setting back down, the data won't come until you completely reload the firmware from the original bit file. We need to investigate this. A hint from Matthew: "it might have to do with exceeded the maximum allowed TCP packet size which is 1500 bytes.  That might be overflowing internal buffers but can be reset by setting and clearing the reset bit in the Ethernet CSR (0xc1000000 I think)".
4. We want to eventually try to capture cosmic rays. I see two ways to try to accomplish this: (1) Record for a long time and modify the Python code to search only for events that see any non-zero voltages in any of the first three channels, or (2) modify the trigger such that it only triggers on events that see a signal in two channels (assuming one comes from the ramp in channel 4).
5. To expand on testing the trigger, I actually tried changing the trigger settings once, so I want to try changing the function generator to output very clearly defined pulses and see if we can get the trigger settings to trigger off of those. It would require someone going to AP-30 to change the function generator.

You can try any of these above things. Even just step one is a good starting point without worrying about any of the other things. 

Other to-do:

1. Simplify GitHub project by expanding the .gitignore file. This will require Google searches + repeatedly cloning the GitHub repo and trying to build the .bit file from what just what the repo gives and see what files are necessary and what can be rebuilt. Obviously for example, not including the project file would break it, as would not including the .vhd source files, but I'm sure there are many files that are being included that aren't necessary. 
