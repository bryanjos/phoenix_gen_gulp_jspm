Phoenix Gulp JSPM Generator
==============

__WARNING__: Only use this on new Phoenix projects

Inspired by the [Phoenix Webpack Generator](https://github.com/BrewhouseTeam/phoenix_gen_webpack)

This generator replaces the default brunch asset management with Gulp.

The Gulp configuration includes tasks for using [babel](https://babeljs.io/) to transile from ES6 to ES5, and [cssnext](http://cssnext.io/) for transpiling css.

The generator also includes a basic [JSPM](http://jspm.io/) setup. 

```elixir
{:phoenix_gen_gulp_jspm, "~> 0.1.0"}
```

Instructions:
```bash
mix deps.get
mix phoenix.gen.gulp.jspm <<app_name>>
npm install
jspm install
mix phoenix.server
```