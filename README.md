# Bun wrapper

🧅 Like [`./gradlew`] but for [Bun]

<table align=center><td>

```sh
./bunw --help
./bunw run main.ts
./bunw build --target=node src/main.ts --outdir=out
```

</table>

🧅 Downloads a pinned version of Bun \
📂 Caches Bun installation in the `.bun` folder \
🌟 Creates a `./bunw` wrapper script that auto-downloads Bun \
👤 Users don't need to install `bun` globally

## Installation

![curl](https://img.shields.io/static/v1?style=for-the-badge&message=curl&color=073551&logo=curl&logoColor=FFFFFF&label=)
![sh](https://img.shields.io/static/v1?style=for-the-badge&message=sh&color=4EAA25&logo=GNU+Bash&logoColor=FFFFFF&label=)

[🛑 Bun doesn't support Windows yet. 😢](https://github.com/oven-sh/bun/issues/43)

```sh
curl -fsSL https://github.com/jcbhmr/bunw/raw/main/install.sh | sh
```

**If you want to install a specific version of Deno** instead of the latest
version you can use an extra argument to choose a specific version. This is the
_version_ (`1.38.0`), not the _tag name_ (`v1.38.0`).

```sh
curl -fsSL https://github.com/jcbhmr/bunw/raw/main/install.sh | sh -s 1.38.0
```

🛑 If you're looking to install Bun globally [check out the Bun website for an
installation guide].

## Usage

![Terminal](https://img.shields.io/static/v1?style=for-the-badge&message=Terminal&color=4D4D4D&logo=Windows+Terminal&logoColor=FFFFFF&label=)
![Linux](https://img.shields.io/static/v1?style=for-the-badge&message=Linux&color=222222&logo=Linux&logoColor=FCC624&label=)
![macOS](https://img.shields.io/static/v1?style=for-the-badge&message=macOS&color=000000&logo=macOS&logoColor=FFFFFF&label=)

Just use `./bunw` as though it were the true `bun` binary! Anyone who clones
your repo won't need to install deno themselves; the `./bunw` will auto-install
a local copy into the `.bun` folder.

⚠️ Make sure you add `.bun` to your `.gitignore`! That's where `bun` will be
installed to by the wrapper.

```sh
./bunw index.ts
./bunw run test:e2e
./bunw run src/main.ts
./bunw build --compile src/app.ts
```

If you want to update the version of Bun that `./bun` downloads and invokes, you
can go through the install steps (above) again to pin to a different version. Be
aware that this will **overwrite** the `./bunw` file. You can also inspect the
generated `./bunw` file to see what version of Deno they are invoking and change
it manually.

### Why?

💡 Inspired by [The Gradle Wrapper]

Sometimes (not often, but sometimes), you want to have an auto-install wrapper
around a project-critical binary. In a nutshell you gain the following benefits:

- Standardizes a project on a given Bun version, leading to more reliable and
  robust builds.

- Provisioning a new Bun version to different users and execution environment
  (e.g. IDEs or Continuous Integration servers) is as simple as changing the
  Wrapper definition.

For instance, GitHub Actions can be written using Bun, but how do you make sure
`bun` is available on the GitHub Action runner? You can use `./bunw` as a proxy!

### Why not just download the `bun` binary as `./bun`?

Because the Bun binary is >50MB, which is more than most version control systems
want to deal with. You'd then need that 2-3 times to cover all OS/arch combos.
It's better to use a wrapper.

## Development

![Bash](https://img.shields.io/static/v1?style=for-the-badge&message=Bash&color=FCAF58&logo=GNU+Bash&logoColor=000000&label=)
![sh](https://img.shields.io/static/v1?style=for-the-badge&message=sh&color=4EAA25&logo=GNU+Bash&logoColor=FFFFFF&label=)

Make sure that any changes are roughly the same in the `./bunw.bat` and `./bunw`
wrappers as well as the `install.ps1` and `install.sh` installers.

<!-- prettier-ignore-start -->
[Bun]: https://bun.sh/
[`./gradlew`]: https://github.com/gradle/gradle/blob/master/gradlew
[The Gradle Wrapper]: https://docs.gradle.org/current/userguide/gradle_wrapper.html
[check out the Bun website for an installation guide]: https://bun.sh/docs/installation
<!-- prettier-ignore-end -->
