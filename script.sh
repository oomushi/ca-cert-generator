#!/bin/bash
jq -s ".[0] * .[1]" /home/step/data.json /home/step/config/ca.json > /home/step/config/ca.json
