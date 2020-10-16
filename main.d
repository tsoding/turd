import std.stdio;
import std.file;
import std.string;
import std.algorithm;
import std.ascii;
import std.array;
import std.exception;
import std.conv;
import std.range;
import std.typecons;
import core.stdc.stdlib;

enum Step
{
    L,
    R,
}

alias State = string;
alias Symbol = string;

struct Turd
{
    State current;
    Symbol read;
    Symbol write;
    Step step;
    State next;
}

struct Machine
{
    Symbol[] tape;
    ulong head;
    State state;

    bool next(Turd[] program)
    {
        foreach (turd; program) {
            if (turd.current == state && turd.read == tape[head]) {
                tape[head] = turd.write;
                final switch (turd.step) {
                case Step.L:
                    if (head == 0) {
                        head = tape.length - 1;
                    } else {
                        head -= 1;
                    }
                    break;
                case Step.R:
                    head = (head + 1) % tape.length;
                    break;
                }
                state = turd.next;
                return true;
            }
        }
        return false;
    }

    void dump()
    {
        writeln("STATE: ", state);
        foreach (cell; tape) {
            write(cell, ' ');
        }
        writeln();
        foreach (i, cell; tape) {
            if (i == head) write('^');
            for (int j = 0; j < cell.length; ++j) {
                write(' ');
            }
            if (i != head) write(' ');
        }
    }
}

Turd parseTurd(string filepath,
               Tuple!(int, "index", string, "value") s)
{
    auto tokens = s.value.split!isWhite.map!(x => x.strip).array;
    if (tokens.length != 5) {
        writeln(filepath, ":", s.index, ": A single turd is expected to have 5 tokens");
        exit(1);
    }

    immutable int CURRENT = 0;
    immutable int READ = 1;
    immutable int WRITE = 2;
    immutable int STEP = 3;
    immutable int NEXT = 4;

    Turd turd;
    turd.current = tokens[CURRENT];
    turd.read = tokens[READ];
    turd.write = tokens[WRITE];
    switch (tokens[STEP]) {
    case "L":
        turd.step = Step.L;
        break;
    case "R":
        turd.step = Step.R;
        break;
    default:
        writeln(filepath, ":", s[0], ": `", tokens[STEP], "` is not a correct step. Expected `L` or `R`.");
        exit(1);
    }
    turd.next = tokens[NEXT];
    return turd;
}

auto states_of_turds(Turd[] turds)
{
    State[] states;

    foreach (turd; turds) {
        states ~= turd.current;
        states ~= turd.next;
    }

    return states.sort!"a < b".uniq.array;
}

int main(string[] args)
{
    if (args.length < 3) {
        stderr.writeln("ERROR: input file is not provided");
        stderr.writeln("Usage: turd <input.turd> <input.tape>");
        return 1;
    }

    auto turd_filepath = args[1];
    auto tape_filepath = args[2];

    auto turds = readText(turd_filepath)
        .splitLines
        .map!(x => x.strip)
        .enumerate(1)
        // Ignore empty lines
        .filter!(x => !x.value.empty)
        // Ignore commented out lines
        .filter!(x => x.value[0] != '#')
        .map!(x => parseTurd(turd_filepath, x))
        .array;

    auto states = states_of_turds(turds);
    
    writeln("Possible States: ");
    foreach (state; states) {
        writeln("  ", state);
    }
    write("What is initial state? ");
    auto initial_state = readln.strip;

    Machine machine;
    machine.head = 0;
    machine.state = initial_state;
    machine.tape = readText(tape_filepath)
        .split!isWhite
        .map!(x => x.strip)
        .array;

    do {
        machine.dump();
        readln();
    } while (machine.next(turds));

    return 0;
}
