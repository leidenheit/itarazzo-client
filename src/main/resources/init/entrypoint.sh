#!/bin/sh

echo "Itarazzo Client"
echo "==============="
echo "#####################################################################"
echo "### WARNING: ACTUAL REQUESTS WILL BE MADE - TAKE CARE OF SECURITY ###"
echo "#####################################################################"
echo "Using arazzo specification located at: $ARAZZO_FILE"
echo "Using inputs located at: $ARAZZO_INPUTS_FILE"

mvn verify -Darazzo.file="$ARAZZO_FILE" -Darazzo-inputs.file="$ARAZZO_INPUTS_FILE"

# force report generation in any case
echo "Generating reports..."
mvn failsafe:verify