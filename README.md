# BASTIONS OF RETROCOMPUTING - Sharp PC-1360

Port of the strategy game [Bastions of Retrocomputing](https://github.com/Ante1000/Sharp_PC-1500_GAME_Bastions_of_Retrocomputing)
(Sharp PC-1500) to the **Sharp PC-1360** (4 lines of 24 characters), derived from the
[PC-1600 version](https://github.com/Ante1000/Sharp_PC-1600_GAME_Bastions_of_Retrocomputing). The algorithm is the same.

> **Status: work in progress, not yet tested on a real PC-1360.** The tape recording (WAV) and the
> instructions are not made yet. For the rules see the instructions of the PC-1600 version.

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
- `RESTORE` uses line number - 1, so it works with either "DATA line >= n" or "> n".
- `BEEP`: the melodies are recomputed for the PC-1360 tone scale (tone t becomes about 1.19 t - 22.5, durations are
  unchanged). This assumes that tone 61 of the PC-1500 melody is A5 (880 Hz): not verified, see the test program.
- Place names and treasures were shortened to fit 24 characters.

## Files

| File | Contents |
|---|---|
| `Basic/bastions_of_retrocomputing-v2.6-pc1360.txt` | the program (BASIC listing, with REM lines) |
| `Basic/bastions_of_retrocomputing-v2.6-pc1360-norem.txt` | the same without REM lines (needs less memory) |
| `Basic/pc1360_test.txt` | short test of what the game relies on: last screen cell, string length, `RESTORE`, `WAIT`, `BEEP`, `INKEY$` speed (type it in and run it first) |

## License

See [LICENSE](LICENSE).
