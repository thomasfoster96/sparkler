cd /workdir
yum -y install centos-release-scl-rh
yum -y install llvm-toolset-7.0
source scl_source enable llvm-toolset-7.0
curl https://sh.rustup.rs -sSf | sh -s -- -y --profile minimal
export PATH="${PATH}:/root/.cargo/bin:/opt/python/cp37-cp37m/bin:/opt/python/cp38-cp38/bin:/opt/python/cp39-cp39/bin:/opt/python/cp310-cp310/bin:/opt/python/cp311-cp311/bin"
cd python
python3.10 -m venv venv
source venv/bin/activate
pip install -r requirements.dev.txt
maturin develop --release -m Cargo.toml
python generate_stubs.py pyoxigraph pyoxigraph.pyi --black
maturin build --release -m Cargo.toml
