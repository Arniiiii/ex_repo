# ex_repo

It's an overlay for Gentoo. I mean, some recipes of how to build some applications or libraries using a Linux distro called Gentoo.

Mostly C++ related recipes.

# How to use it?
First, get a machine with Gentoo. Then:

`emerge eselect-repository`

(optional) `eselect repository add ex_repo git https://github.com/Arniiiii/ex_repo.git `

`eselect repository enable ex_repo`

`emaint sync -r ex_repo`


# Notes

## Previously existed packages:

* `dev-util/cmake-format` : removed because unmaintained and `neocmakelsp` works better.
* `kleidiai` and `llama-cpp` since I do not use them and were somewhat unmaintained.

