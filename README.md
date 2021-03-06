# Turing Machine Interpreter

Simple Turing Machine interpreter implemented in D based on Wikipedia article about Turing Machine: [https://en.wikipedia.org/wiki/Turing_machine](https://en.wikipedia.org/wiki/Turing_machine)

## Quick Start

The build expects [dmd](https://dlang.org/download.html) available in `$PATH`.

```console
$ make
$ ./turd turds/add.turd tapes/input-05.tape
<PRESS ENTER TO STEP DEBUG>
```

## Turd File Format

Turd files (examples are located in the [./turds/](./turds/) folder) are the files that contain instructions for the Turing Machine to interpret:

- Each instruction is located on a separate line.
- Correct instruction has the format: `<CURRENT-STATE> <READ-SYMBOL> <WRITE-SYMBOL> <DIRECTION> <NEXT-STATE>`:
  - `<CURRENT-STATE>` is a sequence of non-space characters that represents the state in which this instruction is activated.
  - `<READ-SYMBOL>` is a sequence of non-space characters that represents the symbol that is read by the head of the machine which along with a specific `<CURRENT-STATE>` activates the instruction.
  - `<WRITE-SYMBOL>` is a sequence of non-space characters that represents the symbol that is written to the current cell on the tape when the instruction is activated.
  - `<DIRECTION>` is either symbol `L` or `R` which indicates the direction in which the head of the Turing Machine should step after executing the instruction.
  - `<NEXT-STATE>` is a sequence of non-space characters that represents the state to which the Machine should switch after executing the instruction.
- Any line may have any amount of leading or trailing whitespaces. All of them are stripped off before processing any instructions.
- Any empty line after stripping whitespace is ignored.
- Any line that starts with `#` after stripping whitespaces is ignored.

## Tape File Format

Tape files (examples are located in the [./tapes/](./tapes/) folders) are the files that contain initial state of the Turing Machine tape.

- A tape file consists of sequence of symbols separated by any amount of whitespace characters.
- Each symbol is a sequence of non-space characters that represents the symbol stored in the corresponding cell of the Machine's tape.

## Execution Process

Execution process starts with
- loading the provided tape file into the tape of the Virtual Turing Machine,
- setting the head position to 0 (can be changed with flag `-p`),
- switch to the state `BEGIN` (can be change with flag `-s`).

Then on each iteration of execution the machine finds the first instruction with the matching `<CURRENT-STATE>` and `<READ-SYMBOL>` and executes that instruction. If the machine cannot find an instruction with the matching `<CURRENT-STATE>` and `<READ-SYMBOL>`it halts.
