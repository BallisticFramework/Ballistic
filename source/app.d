import std.file : readText;
import std.json : JSONValue, parseJSON;
import std.process : execute;
import std.stdio : writeln;

JSONValue dubJsonConfig;

void main(string[] args)
{
    argsManager(args);
}

void argsManager(string[] args)
{
    dubJsonConfig = parseJSON(readText("dub.json"));

    if (args.length <= 1)
    {
        helpCommand();
        return;
    }

    switch (args[1])
    {
        case "build":
            buildCommand(args[2 .. $]);
            break;

        case "run":
            runCommand(args[2 .. $]);
            break;

        case "help":
            helpCommand();
            break;

        default:
            writeln("Unknown command: ", args[1]);
            writeln("Usage: ballistic [build|run|help]");
    }
}

void buildCommand(string[] flags)
{
    writeln("Building ", dubJsonConfig["name"].str, "...");
    execute(["dub", "build"] ~ flags);
}

void runCommand(string[] flags)
{
    writeln("Running ", dubJsonConfig["name"].str, "...");
    execute(["dub", "run"] ~ flags);
}

void helpCommand()
{
    writeln("Ballistic ");
    writeln("Usage: ballistic [build,run,help] [flags]");
    writeln();
    writeln("  build   generate pages, then compile");
    writeln("  run     build and launch");
    writeln("  help    show this message");
    writeln();
    writeln("Flags pass through to dub, e.g. ballistic build --release");
}