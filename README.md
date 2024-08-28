# ex_repo

Welcome! It's an overlay for gentoo.

# How to?
First of all, get a machine with gentoo. Then:

`emerge eselect-repository`

`eselect repository add ex_repo git https://github.com/Gerodote/ex_repo.git `

`eselect repository enable ex_repo`

`emaint sync -r ex_repo`

