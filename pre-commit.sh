#!/bin/bash


read name version < <(poetry version)

read pversion < <(poetry run python -c  "from ${name} import __version__;print(__version__)")

init=${name}/__init__.py
if [ ! -f ${init} ]; then
    init=src/${name}/__init__.py
fi

testfn=tests/test_${name}.py

if [[ "${pversion}" != "${version}" ]]; then
    if [[ -r $init ]]; then
        sed -i 's/\(__version__ = "\)[0-9."]\+$/\1'${version}'"/' $init
    fi
    if [[ -r $testfn ]]; then
        sed -i 's/\(__version__ == "\)[0-9."]\+$/\1'${version}'"/' $testfn
    fi
    git add $init
    git add $testfn
fi
