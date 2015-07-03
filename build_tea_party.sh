#!/bin/sh
BASE_DIR=$(cd `dirname $0`; pwd)
TEA_DIR=$BASE_DIR/spa/tea

cd $TEA_DIR
if [ $? -ne 0 ]; then echo "cd $TEA_DIR failed."; exit 1; fi

bundle install --path=vendor/bundle
if [ $? -ne 0 ]; then echo "bundle install failed."; exit 1; fi

npm install
if [ $? -ne 0 ]; then echo "npn install failed."; exit 1; fi

bower install
if [ $? -ne 0 ]; then echo "bower install failed."; exit 1; fi

for task in clean build
do
  gulp $task
  if [ $? -ne 0 ]; then echo "gulp $task failed."; exit 1; fi
done

cd $BASE_DIR
if [ $? -ne 0 ]; then echo "cd $BASE_DIR failed."; exit 1; fi

if [ x"$EXEC_PARENT" != x ]; then
  bundle install --path=vendor/bundle
  if [ $? -ne 0 ]; then echo "bundle install failed."; exit 1; fi

  npm install
  if [ $? -ne 0 ]; then echo "npn install failed."; exit 1; fi
  
  for task in bower vendor css
  do
    gulp $task
    if [ $? -ne 0 ]; then echo "gulp $task failed."; exit 1; fi
  done
fi

for task in clean deploy
do
  gulp --gulpfile=gulpfile_tea.coffee $task
  if [ $? -ne 0 ]; then echo "gulp for tea_party $task failed."; exit 1; fi
done

echo 'ALL OVER'
