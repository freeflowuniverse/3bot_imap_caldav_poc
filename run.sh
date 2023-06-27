pushd poc0
sh run.sh &
popd

sleep 2

pushd poc1
sh run.sh
popd

trap "trap - SIGTERM && kill -- -$$" SIGINT SIGTERM EXIT