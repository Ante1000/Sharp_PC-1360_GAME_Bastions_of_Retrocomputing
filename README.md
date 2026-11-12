# BASTIONS OF RETROCOMPUTING - Sharp PC-1360

Port of the strategy game [Bastions of Retrocomputing](https://github.com/Ante1000/Sharp_PC-1500_GAME_Bastions_of_Retrocomputing)
(Sharp PC-1500) to the **Sharp PC-1360** (4 lines of 24 characters), derived from the
[PC-1600 version](https://github.com/Ante1000/Sharp_PC-1600_GAME_Bastions_of_Retrocomputing). The algorithm is the same.

> **Status: work in progress.** The test program was run on a real PC-1360 (display, `THEN LET`, `RESTORE`, sound
> and the `INKEY$` speed are checked and the game is adjusted to them); the game itself is not tested yet.
> The instructions are not made yet; for the rules see the instructions of the PC-1600 version.

## Screen (24 x 4)

- line 1: tokens `Tnnnnn` (left), mode (middle: MAIN MENU, FIGHT, BUY, SELL, RESOURCES, TAX), retro stuff `Rnnnn` (right);
  in a fight the whole line shows `Place - nnP` (Tech Priests still active). Hidden during the title music
- lines 2 and 3: the game (messages and questions; important messages are centred)
- line 4: `Hnn Gnn Dnn Tnn` = Hackers, Gurus, Daemons, Trojans in fixed fields (a field that grows blinks);
  in a fight only the forces thrown into it, in small letters: `hnn gnn dnn tnn`
- the main menu is `F)IGHT B)UY S)ELL` / `T)AX R)ES E)ND ?`

## Differences from the PC-1600 version

- 24 columns: shorter texts, some messages on two lines, fight animation 12+12 characters, `CURSOR x,y` 0-23 / 0-3.
- Variables: two-letter simple variables (`TK`, `ZW`, ...) are used directly (PC-1360 BASIC needs no `DIM` for them).
- `WAIT n` is n/59 s on the PC-1360 (n/64 s on the PC-1600): the pauses are converted.
- `RESTORE n` needs an existing line n (it points to the DATA at or after n): the game uses the number of the DATA line itself.
- `BEEP`: the melodies are recomputed for the PC-1360 tone scale (tone t becomes about 1.19 t - 22.5, durations are
  unchanged). This assumes that tone 61 of the PC-1500 melody is A5 (880 Hz): not verified, see the test program.
- Place names and treasures were shortened to fit 24 characters.
- The PC-1360 is slow: the routines used all the time (melody, key, screen) are at the start of the program (jumps are
  found from the first line), numbers are typed without `(MAX n)` and each digit is printed at once, the pauses
  (`WAIT`) are about 35% of the PC-1600 ones, the surrender key loop uses no `FOR`/`NEXT`.

## Files

| File | Contents |
|---|---|
| `Basic/bastions_of_retrocomputing-v2.6-pc1360.txt` | the program (BASIC listing, with REM lines) |
| `Basic/bastions_of_retrocomputing-v2.6-pc1360-norem.txt` | the same without REM lines (needs less memory) |
| `wav/bastions-v2.6-pc1360.wav` | tape recording of the game (name on the tape: BASTION) |
| `wav/pc1360_test.wav` | tape recording of the test program (name: PCTEST) |
| `tools/` | `make_wav.sh` and the Sharp Pocket-Tools sources (`bas2img.c`, `bin2wav.c`, `wav2bin.c`, with their own license notes) |
| `Basic/pc1360_test.txt` | short test of what the game relies on: last screen cell, string length, `RESTORE`, `WAIT`, `BEEP`, `INKEY$` speed (type it in and run it first) |

## Loading from the recording

1. Connect the audio output of a computer or player to the cassette input of the PC-1360 (e.g. through the CE-126P) and
   select PRO mode.
2. Type `CLOAD "BASTION"` [ENTER] (or `CLOAD` for the first program) and play `wav/bastions-v2.6-pc1360.wav`
   (about 4.5 minutes). The test program is `CLOAD "PCTEST"` with `wav/pc1360_test.wav`.
3. Select RUN mode and type `RUN`.

The recording holds the program without its REM lines (9755 bytes of intermediate code).

## Making a recording

`tools/make_wav.sh` converts a BASIC listing into a recording with the Sharp Pocket-Tools
(`bas2img` -> `bin2wav`, sources in `tools/`, compiled with `gcc` on first use) and reads it back with `wav2bin`
to check that it is identical:

```
tools/make_wav.sh Basic/bastions_of_retrocomputing-v2.6-pc1360-norem.txt wav/bastions-v2.6-pc1360.wav BASTION
```

## License

See [LICENSE](LICENSE).
