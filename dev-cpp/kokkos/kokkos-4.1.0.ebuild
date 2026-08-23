# Copyright 2026 Arniiiii lg3dx6fd@gmail.com
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake toolchain-funcs

DESCRIPTION="C++ Performance Portability Programming EcoSystem"
HOMEPAGE="https://github.com/kokkos"
SRC_URI="https://github.com/kokkos/kokkos/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="-x86"
IUSE="+serial +openmp cuda threads hip sycl test"
RESTRICT="!test? ( test )"

REQUIRED_USE="
openmp? ( !threads )
threads? ( !openmp )
"

DEPEND="
sys-apps/hwloc:=
openmp? (
	|| (
		sys-devel/gcc[openmp]
		llvm-core/clang
	)
)
cuda? (
	|| (
		dev-util/nvidia-cuda-toolkit
		>=llvm-core/clang-10
	)
)
hip? (
	dev-util/hip
)
sycl? (
	|| (
		dev-cpp/tbb
		dev-cpp/adaptivecpp
	)
)

"
RDEPEND="${DEPEND}"

pkg_pretend() {
	[[ ${MERGE_TYPE} != binary ]] && use openmp && tc-check-openmp
}

pkg_setup() {
	[[ ${MERGE_TYPE} != binary ]] && use openmp && tc-check-openmp
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_INCLUDEDIR=include/kokkos
		-DKokkos_ENABLE_TESTS=$(usex test)
		-DKokkos_ENABLE_AGGRESSIVE_VECTORIZATION=ON
		-DKokkos_ENABLE_SERIAL=$(usex serial)
		-DKokkos_ENABLE_HWLOC=ON
		-DKokkos_HWLOC_DIR="${EPREFIX}/usr"
		-DKokkos_ENABLE_OPENMP=$(usex openmp)
		-DBUILD_SHARED_LIBS=ON
		-DKokkos_ENABLE_CUDA=$(usex cuda)
		-DKokkos_ENABLE_HIP=$(usex hip)
		-DKokkos_ENABLE_SYCL=$(usex sycl)
		-DKokkos_ENABLE_THREADS=$(usex threads)
	)

	cmake_src_configure
}

src_test() {
	local myctestargs=(
		# Contains "death tests" which are known/expected(?) to fail
		# https://github.com/kokkos/kokkos/issues/3033
		# bug #791514
		-E "(KokkosCore_UnitTest_OpenMP|KokkosCore_UnitTest_Serial)"
	)

	cmake_src_test
}
