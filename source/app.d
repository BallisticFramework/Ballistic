
import std : writeln;
import std.file : read;
import std.json;
import std.process : executeShell;
JSONValue dubJsonConfig;

void main(string[] args)
{

ArgsManager(args:args);

}

void ArgsManager(string[] args)
{


    dubJsonConfig = parseJSON(cast(string) read("dub.json"));

    if (args.length <= 1)
    {
        writeln("Usage: ballistic [build,run]");
        return;
    }

    switch (args[1])
    {
        case "build":
            buildCommand();
            break;

        case "run":
            runCommand();
            break;

		case "help":
			helpCommand();
			break;

        default:
            writeln("Unknown command: ", args[1]);
    }

}
void buildCommand()
{

    writeln("Building ", dubJsonConfig["name"].str, "...");
    writeln(executeShell("dub build")) ;

}

void runCommand()
{


    writeln("Running ", dubJsonConfig["name"].str, "...");
   writeln(executeShell("dub run")); 


}
void helpCommand()
{
	   writeln("help");
   writeln("Usage: ballistic [build,run]");
}


