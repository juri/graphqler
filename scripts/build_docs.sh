#!/bin/bash

swift package plugin \
    --allow-writing-to-directory ./docs \
    generate-documentation --target GraphQLer \
    --disable-indexing \
    --transform-for-static-hosting \
    --hosting-base-path graphqler \
    --output-path ./docs
