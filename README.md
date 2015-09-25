Phoenix Gulp JSPM Generator
==============

__WARNING__: Only use this on new Phoenix projects

Inspired by the [Phoenix Webpack Generator](https://github.com/BrewhouseTeam/phoenix_gen_webpack)

This generator replaces the default brunch asset management with Gulp.

```elixir
  defp deps do
    [{:phoenix_gen_gulp_jspm, "~> 1.0"}]
  end
```

The Gulp configuration includes tasks for using [babel](https://babeljs.io/) to transile from ES6 to ES5, and [cssnext](http://cssnext.io/) for transpiling css.

The generator also includes a basic [JSPM](http://jspm.io/) setup. This requires jspm to be installed. You cen do so by running the following on your command line

```bash
npm install -g jspm
``` 

Instructions:
```bash
mix phoenix.gen.gulp.jspm app_name
npm install && jspm install
mix phoenix.server
```