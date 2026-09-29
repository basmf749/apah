# apah

## Overview
This repository holds the firmware specification for the APAH ridge weather station cluster.

## Sensor array
Each station carries a combined sensor head reporting temperature, relative humidity, and barometric pressure at one reading per hour.

## Data
Readings are buffered locally for 24 hours and synced once per day to the cluster aggregator, which publishes a rolling line-chart dashboard.

## Power
Stations run on a 20W solar panel with a 6Ah LiFePO4 buffer; the pressure sensor is polled last to shorten the wake window.
