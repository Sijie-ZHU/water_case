# 南京理想化河岸微气候算例

这是课程报告里从00:00算到18:00的南京河岸案例。两岸设有步道、绿地和建筑，西岸草带设有树冠。河道长76 m、宽20 m，水面低于岸顶1 m。近岸和主河道各用一根1.5 m深的水柱表示，每根分12层。

空气、地面、建筑和植被分别划分网格。空气域有1,491,105个单元。配置采用8个MPI进程，物理步长3600 s，每步最多做2000次空气SIMPLE迭代。水温采用waterPicard耦合。

## 解包并运行

先按课程发放的源码包编译OpenFOAM Foundation 8版求解器urbanMicroclimateFoamRiverMPI。下面的前两行请换成本机安装路径。从克隆的仓库根目录，在Linux或WSL终端运行：

```bash
source /opt/openfoam8/etc/bashrc
source ~/urbanMicroclimateFoam-RiverV2-OF8/etc/river-env.sh
bash prepare.sh
cd run
mpirun --bind-to none -np 8 urbanMicroclimateFoamRiverMPI -parallel > log.solver 2>&1
```

prepare.sh把输入文件展开到新建的run目录，也可传入另一个尚不存在的目录。包内已带与正式计算一致的8个分区，以及逐分区的冠层和辐射预处理输入，可以直接启动上述命令。展开后需要约2 GiB空间，后续写出计算场需要另留磁盘空间。

## 查看输入

- `run/system/controlDict`设置起止时刻、物理步长和空气迭代上限。
- `run/constant/air/waterProperties`设置两水区的水深、分层、辐射吸收和底泥换热。
- `run/constant/IDN`、`Idif`和`sunPosVector`给定太阳辐射及太阳位置。四侧风速输入在`run/constant/air/Utarget_*`。
- `run/0/`含00:00的初场。用ParaView打开`run/nanjing-river.foam`可查看整域网格。
- `case/`中保留可直接阅读的字典和小文件，`inputs/`存放按区域或分区压缩的大文件。所有输入均来自正式南京算例的初始目录、常量目录和系统配置。计算产生的时刻目录、日志及后处理输出未收录。
