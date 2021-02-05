
here=${pwd}
docker run -p 8888:8888 \
            -v /home/barak/Projects/hello_qiskit/notebook:/notebook \
            --name qk qiskit