inherit systemd

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
    file://chkrootkit.service \
    file://chkrootkit.timer \
    file://chkrootkit.patch \
"

do_install:append () {
    # Install service for chkrootkit
    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/chkrootkit.service ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/chkrootkit.timer ${D}${systemd_system_unitdir}
}

PACKAGES += "${PN}-timer"
SYSTEMD_PACKAGES = "${PN} ${PN}-timer"
SYSTEMD_SERVICE:${PN} = "chkrootkit.service"
SYSTEMD_SERVICE:${PN}-timer = "chkrootkit.timer"
SYSTEMD_AUTO_ENABLE:${PN} = "disable"
SYSTEMD_AUTO_ENABLE:${PN}-timer = "enable"
