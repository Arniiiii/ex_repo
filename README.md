# ex_repo

Welcome! It's an overlay for gentoo.

# how to?
first of all, get a machine with gentoo. then:

`emerge eselect-repository`

`eselect repository add ex_repo git https://github.com/Gerodote/ex_repo.git `

`eselect repository enable ex_repo`

`emaint sync -r ex_repo`

then try `emerge -av musikcube` or `equery u media-sound/musikcube::ex_repo`. ( It works, but in GURU better )

also try `emerge -av dev-libs/dbus-cxx` and `emerge -av dev-libs/cppgenerate`

