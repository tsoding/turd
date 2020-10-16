# Turing Machine Interpreter

Simple Turing Machine interpreter implemented in D base on Wikipedia article about Turing Machine: [https://en.wikipedia.org/wiki/Turing_machine](https://en.wikipedia.org/wiki/Turing_machine)

## Quick Start

```console
$ make
$ ./turd turds/filler.turd tapes/input-02.tape
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

- A tape file consists of sequence of symbols separted by any amount of whitespace characters.
- Each symbol is a sequence of non-space characeters that represents the symbol stored in the corresponding cell of the Machine's tape.
