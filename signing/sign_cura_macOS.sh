#!/bin/bash

# Sign the libraries of the application
echo "===================================="
echo "Signing the libraries of Divid . . ."
echo "===================================="
find ./Ultimaker\ Divid.app -name "*.dylib" -exec codesign --verbose --force --sign $codesign_identity {} \;
find ./Ultimaker\ Divid.app -name "*.so" -exec codesign --entitlements ../../signing/cura.entitlements --verbose --force -o runtime --sign $codesign_identity {} \;
Divid
# Sign the application itself
echo "===================================="
echo "Signing the Zmorph Divid.app . . ."
echo "===================================="
codesign --entitlements ../../signing/cura.entitlements --verbose --force --deep -o runtime --sign $codesign_identity "Zmorph Divid.app"
