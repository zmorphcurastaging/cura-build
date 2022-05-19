include(CPackComponent)

include(packaging/cpackconfig_common.cmake)

# ========================================
# MSI
# ========================================
set(CPACK_WIX_CULTURES "en-US")
set(CPACK_WIX_PRODUCT_GUID "${CURA_MSI_PRODUCT_GUID}")
set(CPACK_WIX_UPGRADE_GUID "${CURA_MSI_UPGRADE_GUID}")
set(CPACK_WIX_PRODUCT_ICON "${CMAKE_SOURCE_DIR}/packaging/cura.ico")
set(CPACK_WIX_UI_BANNER "${CMAKE_SOURCE_DIR}/packaging/cura_banner_msi.bmp")
set(CPACK_WIX_UI_DIALOG "${CMAKE_SOURCE_DIR}/packaging/cura_background_msi.bmp")
if(CURA_BUILDTYPE STREQUAL "")
    set(CPACK_WIX_PROGRAM_MENU_FOLDER "Ultimaker Cura")
else()
    set(CPACK_WIX_PROGRAM_MENU_FOLDER "Ultimaker Cura ${CURA_BUILDTYPE}")
endif()
set(CPACK_WIX_TEMPLATE "${CMAKE_SOURCE_DIR}/packaging/cura.wxs")
set(CPACK_WIX_PROPERTY_ARPINSTALLLOCATION "${CPACK_PACKAGE_INSTALL_DIRECTORY}")
