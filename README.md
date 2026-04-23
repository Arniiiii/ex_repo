# ex_repo

It's an overlay for Gentoo. I mean, some recipes of how to build some applications or libraries using a Linux distro called Gentoo and its package manager Portage.

Mostly C++ related recipes.

# How to use it?

First, get a machine with Gentoo. Then:

`emerge eselect-repository`

(optional) `eselect repository add ex_repo git https://github.com/Arniiiii/ex_repo.git `

`eselect repository enable ex_repo`

`emaint sync -r ex_repo`

# Notes

## Previously existed packages:

- `dev-util/cmake-format` : removed because unmaintained and `neocmakelsp` works better.
- `kleidiai` and `llama-cpp` since I do not use them and were somewhat unmaintained.
- `dev-libs/softhsm` I do not maintain it nowadays
- `rssguard-9999` no need
- `games-action/prismlauncher-cracked` it is possible to use `-9999` version and fix URL or repo, I guess
- `tmux-9999`. Patch is already in master

# TODO

## Add

- [ ] `dev-cpp/sqlpp23`
- [ ] `dev-cpp/inja` Why does it exist in `conan` but not in Gentoo ?
- [ ] `dev-cpp/adaptivecpp` at least for CPU, Nvidia GPU at if possible with Intel iGPU support. I can't write for AMD GPU since I do not have one to test it.

## Update

- [ ] `kokkos` update right after `adaptivecpp` one
- [ ] `bazel`
- [ ] `boost` (CMake). It is too big of a project to test it and send patches... Forever in `**`.

## Improve

- [ ] CI
    - Maybe copy main part from `::p4public` ? 
- [ ] Automatic pull of RSS feeds of releases/commits and try to do pull-requests with CI enabled
