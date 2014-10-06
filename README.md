# Diet plugin for CoffeeScript

----

Compiles CoffeeScript in Diet templates to JavaScript and caches the result.

## Usage

To register the plugin you have to `import diet_coffee;` in your application.

```d
import vibe.d;
import diet_coffee;

//...

void hello(HTTPServerRequest req, HTTPServerResponse res)
{
    res.render!"coffee.dt"();
}
```

Now you can use the `:coffee` textfilter in your diet files.

```jade
doctype html
html
  head
    title Hello, CoffeeScript
  body
    :coffee
      window.onload = -> alert document.title
```

See [example](https://github.com/MartinNowak/diet-coffee/tree/master/example) for a complete vibe.d app.
