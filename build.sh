sudo chmod +x start_node-red.sh
docker build -t frogconn/node-red-oracle-mod --build-arg ORACLE_VERS=12.1.0.2.0 -f Dockerfile.node-red-oracle .
