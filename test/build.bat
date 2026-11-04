call "C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\VC\Auxiliary\Build\vcvarsall.bat" x64
set CUDA_HOME=C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v12.8
set MAX_JOBS=1

REM Python 3.12
py -3.12 -m venv ..\.venv312
..\.venv312\Scripts\pip install torch==2.7.1 torchvision --index-url https://download.pytorch.org/whl/cu128
..\.venv312\Scripts\pip install ninja packaging
..\.venv312\Scripts\python ..\build_wheels.py

REM Python 3.13 (repeat in new venv)
py -3.13 -m venv ..\.venv313
..\.venv313\Scripts\pip install torch==2.7.1 torchvision --index-url https://download.pytorch.org/whl/cu128
..\.venv313\Scripts\pip install ninja packaging
..\.venv313\Scripts\python ..\build_wheels.py

REM Python 3.14 (no cp314 torch 2.7.1 wheels; torch 2.14.1 needs CUDA 13, nvcc 13.0 needs MSVC 14.4x)
set CUDA_HOME=C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v13.0
set TORCH_CUDA_ARCH_LIST=7.5;8.0;8.6;8.9;9.0;10.0;12.0+PTX
py -3.14 -m venv ..\.venv314
..\.venv314\Scripts\pip install torch==2.14.1 torchvision==0.29.1 --index-url https://download.pytorch.org/whl/cu130
..\.venv314\Scripts\pip install ninja packaging setuptools wheel
..\.venv314\Scripts\python ..\build_wheels.py
pause
