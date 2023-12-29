NVCC = nvcc
NVCC_FLAGS = -O2 -arch=sm_70

all: a3

a3: a3.cpp a3.cu a3_cpu.cpp
	$(NVCC) $(NVCC_FLAGS) a3.cpp a3.cu a3_cpu.cpp -o a3

clean:
	rm -f a3
