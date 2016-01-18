# Heroku Buildpack: Go

This is an alternative buildpack for [Go][go] - built on the standard [Heroku buildpack][buildpack].

## Getting Started

Add a `production_build_go.json` file at the root of your project, this should specify the Go version, and the app name:

```
{
  "GoVersion": "go1.5.3",
  "Name": "myapp"
}
```

Dependencies must be added to the /vendor folder (following GO15VENDOREXPERIMENT and onwards standard). A great tool for this is [GoVendor][govendor].

This buildpack will detect your repository as Go if it contains a `production_build_go.json` file.

## Stuff From Base Heroku Buildpack

### Using with cgo

This buildpack supports building with C dependencies via
[cgo][cgo]. You can set config vars to specify CGO flags
to, e.g., specify paths for vendored dependencies. E.g., to build
[gopgsqldriver](https://github.com/jbarham/gopgsqldriver), add the config var
`CGO_CFLAGS` with the value `-I/app/code/vendor/include/postgresql` and include
the relevant Postgres header files in `vendor/include/postgresql/` in your app.

### Passing a symbol (and optional string) to the linker

This buildpack supports the go [linker's][go-linker] ability (`-X symbol
value`) to set the value of a string at link time. This can be done by setting
`GO_LINKER_SYMBOL` and `GO_LINKER_VALUE` in the application's config before
pushing code. If `GO_LINKER_SYMBOL` is set, but `GO_LINKER_VALUE` isn't set
then `GO_LINKER_VALUE` defaults to [`$SOURCE_VERSION`][source-version].

This can be used to embed the commit sha, or other build specific data directly
into the compiled executable.

[go]: http://golang.org/
[buildpack]: http://devcenter.heroku.com/articles/buildpacks
[go-linker]: https://golang.org/cmd/ld/
[godep]: https://github.com/tools/godep
[quickstart]: http://mmcgrana.github.com/2012/09/getting-started-with-go-on-heroku.html
[build-constraint]: http://golang.org/pkg/go/build/
[app-engine-build-constraints]: http://blog.golang.org/2013/01/the-app-engine-sdk-and-workspaces-gopath.html
[source-version]: https://devcenter.heroku.com/articles/buildpack-api#bin-compile
[cgo]: http://golang.org/cmd/cgo/
[govendor]: https://github.com/kardianos/govendor
