#!/bin/bash
cd output/appimages
FILENAME=$(basename *.AppImage)
sha1sum ${FILENAME} > ${FILENAME}.sha1