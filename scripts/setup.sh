#!/usr/bin/env bash

gem install bundler
pip install --user awscli
pip install --user aws-sam-cli
npm install
npm run build
