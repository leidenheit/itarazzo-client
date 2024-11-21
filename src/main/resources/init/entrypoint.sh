#!/bin/sh

echo "==============="
echo "Itarazzo Client"
echo "#####################################################################"
echo "### WARNING: ACTUAL REQUESTS WILL BE MADE - TAKE CARE OF SECURITY ###"
echo "#####################################################################"

if [ -z "$ARAZZO_FILE" ] || [ -z "$ARAZZO_INPUTS_FILE" ]; then
    echo "Error: Environment variables ARAZZO_FILE and/or ARAZZO_INPUTS_FILE are not set."
    exit 1
fi

echo "Execution will be started."
mvn verify -q -B -Darazzo.file="$ARAZZO_FILE" -Darazzo-inputs.file="$ARAZZO_INPUTS_FILE"

# force report generation in any case
echo "Reports will be generated."
mvn failsafe:verify -q -B
