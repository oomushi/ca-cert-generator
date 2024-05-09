#!/bin/bash
jq -s ".[0] * .[1]" /home/step/resources/data.json /home/step/config/ca.json > /home/step/config/tmp.json
mv /home/step/config/tmp.json /home/step/config/ca.json
