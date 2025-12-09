# ex_repo

Welcome! It's an overlay for gentoo.

# How to?
First of all, get a machine with gentoo. Then:

`emerge eselect-repository`

(optional) `eselect repository add ex_repo git https://github.com/Arniiiii/ex_repo.git `

`eselect repository enable ex_repo`

`emaint sync -r ex_repo`


# Notes

Previously existed packages:

* `dev-util/cmake-format` : removed because unmaintained and `neocmakelsp` works better.
