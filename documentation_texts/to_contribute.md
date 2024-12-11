### Things to try doing (if you're reading this!)
1. Follow the steps in [`README.md`](../README.md) and practice trying to take data
2. Try changing some of the parameters by doing in the minicomA window `poke cf000048 c8` while stream is off and then turn it back on and take new data. This will set the raw waveform window from 200ns to 400ns. See if it still takes data.
3. There is some kind of maximum amount of time allowed for the raw waveform window. If you set the setting too high, then all data stops coming, and even if you turn the setting back down, the data won't come until you completely reload the firmware from the original bit file. We need to investigate this.
4. Channels 1-3 of the data should be PMTs producing pretty much just 0V. Channel 4 should be the DC ramp from -2.3V to +2.3V, but right now it seems to be stuck around 0V. We should investigate this. (I'm assuming the signal generator is properly putting out a signal!)

You can try any of these above things. Even just step one is a good starting point without worrying about any of the other things. 

Other to-do:

1. Simplify GitHub project by expanding the .gitignore file. This will require Google searches + repeatedly cloning the GitHub repo and trying to build the .bit file from what just what the repo gives and see what files are necessary and what can be rebuilt. Obviously for example, not including the project file would break it, as would not including the .vhd source files, but I'm sure there are many files that are being included that aren't necessary. 