#!/bin/sh

ps -ef | grep snmpsimd | grep -v grep | cut -c 9-15 | xargs kill -9
