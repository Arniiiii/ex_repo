# ex_repo

Welcome! It's an overlay for gentoo.

# how to?
first of all, get a machine with gentoo. then:

`emerge eselect-repository`

`eselect repository add ex_repo git https://github.com/Gerodote/ex_repo.git `

`eselect repository enable ex_repo`

`emaint sync -r ex_repo`

