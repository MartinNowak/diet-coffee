module diet_coffee;

version (Have_vibe_d)
{
    static this()
    {
        import vibe.templ.diet, std.functional;
        registerDietTextFilter("coffee", &memoize!filterCoffee);
    }
}

string filterCoffee(string script, size_t indent)
in { assert(indent > 0); }
body
{
    version (Have_vibe_d)
    {
        import vibe.core.log;
        logDebug("compiling coffee-script");
    }
    import std.array, std.process;

    auto pipes = pipeShell("coffee -cs", Redirect.stdin | Redirect.stdout);
    scope (exit) wait(pipes.pid);
    pipes.stdin.rawWrite(script);
    pipes.stdin.close();

    string indent_string = "\n";
    while (indent-- > 0) indent_string ~= '\t';
    auto res = appender!string();
    res ~= indent_string[0 .. $-1]~"<script type=\"text/javascript\">";
    res ~= indent_string~"//<![CDATA[";
    foreach (line; pipes.stdout.byLine()) {
        res ~= indent_string;
        res ~= line;
    }
    res ~= indent_string~"//]]>";
    res ~= indent_string[0 .. $-1]~"</script>";

    return res.data;
}

unittest
{
    import std.algorithm;
    assert(filterCoffee("3 + 2", 1).canFind("3 + 2"));
    assert(filterCoffee("foo = (a) -> 2 * a", 1).canFind("foo = function(a)"));
}
