import vibe.d;
import diet_coffee; /// import diet_coffee to register filter

shared static this()
{
    auto settings = new HTTPServerSettings;
    settings.port = 8080;
    settings.bindAddresses = ["::1", "127.0.0.1"];
    listenHTTP(settings, &hello);

    logInfo("Please open http://127.0.0.1:8080/ in your browser.");
}

void hello(HTTPServerRequest req, HTTPServerResponse res)
{
    res.render!"hello_coffee.dt"();
}
