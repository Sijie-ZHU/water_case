# 水柱热湿交换练习

这是urbanMicroclimateFoam River V2教学版中的小水柱案例。两块水面共用一个六层水柱，通过给定的净短波和下行长波，以及空气与水面间的显热和水汽通量，计算水温变化。本案例的物理时间步为30 s，共两步。

## 文件

- `0/air/`是空气域初场与边界条件。
- `constant/air/polyMesh/`是算例网格。网格也可用`blockMesh -region air`重建。
- `constant/air/waterProperties`设置水面分区、水柱热参数和`waterPicard`耦合。
- `system/controlDict`设置物理步长、运行时间和SIMPLE迭代上限。

## 运行

先在Linux或WSL中编译课程发放的`urbanMicroclimateFoam-RiverV2-OF8.tar.gz`。之后在同一终端加载OpenFOAM Foundation 8和求解器环境，再进入本算例目录。下面两条`source`命令中的路径按实际安装位置填写。

```bash
source /opt/openfoam8/etc/bashrc
source ~/urbanMicroclimateFoam-RiverV2-OF8/etc/river-env.sh
urbanMicroclimateFoamRiverMPI > log.solver 2>&1
```

双进程可在一份干净的算例副本中运行：

```bash
decomposePar -allRegions > log.decompose 2>&1
mpirun -np 2 urbanMicroclimateFoamRiverMPI -parallel > log.solver 2>&1
```

自己运行后，可在日志中查看`WaterStepCommitted`，在`postProcessing/waterThermal/air/`查看水柱热量收支和温度剖面。并行运行时CSV在`processor0`下。
