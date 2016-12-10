

docker build -t gregorycox/simple_node_test .

docker run -it --rm gregorycox/simple_node_test

docker run -it --rm gregorycox/simple_node_test node_modules/mocha/bin/mocha

