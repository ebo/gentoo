# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_QTHELP="false"
PVCUT=$(ver_cut 1-2)
QTMIN=5.15.2
VIRTUALX_REQUIRED="test"
inherit ecm kde.org

DESCRIPTION="Framework for integrating Qt applications with KDE Plasma workspaces"

LICENSE="LGPL-2+"
KEYWORDS="amd64 ~arm ~arm64 ~ppc64 ~riscv x86"
IUSE=""

# requires running Plasma environment
RESTRICT="test"

RDEPEND="
	>=dev-qt/qtgui-${QTMIN}:5
	>=dev-qt/qtwidgets-${QTMIN}:5
	=kde-frameworks/kconfig-${PVCUT}*:5
	=kde-frameworks/kconfigwidgets-${PVCUT}*:5
	=kde-frameworks/ki18n-${PVCUT}*:5
	=kde-frameworks/kiconthemes-${PVCUT}*:5
	=kde-frameworks/knewstuff-${PVCUT}*:5
	=kde-frameworks/knotifications-${PVCUT}*:5
"
DEPEND="${RDEPEND}
	=kde-frameworks/kpackage-${PVCUT}*:5
	=kde-frameworks/kwidgetsaddons-${PVCUT}*:5
"

PATCHES=( "${FILESDIR}"/${P}-fix-install-KNS-items-w-deps.patch ) # KDE-bug 448237

src_configure() {
	local mycmakeargs=(
		-DCMAKE_DISABLE_FIND_PACKAGE_AppStreamQt=ON
		-DCMAKE_DISABLE_FIND_PACKAGE_packagekitqt5=ON
	)

	ecm_src_configure
}
