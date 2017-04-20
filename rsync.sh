#!/bin/sh

cd $(dirname $0)
rsync -avp ./home/ ~/

